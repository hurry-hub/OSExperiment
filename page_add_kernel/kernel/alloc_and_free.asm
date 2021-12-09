global alloc_pages
global free_pages
global Bitmap

;Data Area

PhysicalPageBuf: times 32 dd 0
LinearPageBuf: times 32 dd 0
Bitmap: times 32 db 11111111b
        times 992 db 0


; 申请页，得到页的线性地址放在LinearPageBuf中 -----------------------------------
alloc_pages:
	; xchg bx, bx
	mov esi, BitMap
	mov edi, 0
	mov ecx, 1024
.1:
	; 查找一个字节中的8位是否有未分配的位
	mov bl, 80h		; 待测试位在bl中，每次右移一位
	push ecx
	mov edx, 1024
	sub edx, ecx	; 现在，edx中是正在查找字节的序号
	mov ecx, 8		; 总共有8位需要测试

.2:
	mov al, byte [esi]
	test al, bl
	jnz .next_bit	; 这一位为1，已经分配，直接考虑下一位
	or al, bl		; 这一位为0，可以分配，将其修改为1
	mov byte [esi], al

	; 接下来，算出这一位对应页的线性地址，填写到返回缓冲区
	push ebx
	push edx

	xor eax, eax
	mov ax, dx
	mov bx, 8
	mul bx			; ax中现在是字节序号*8，需要再加上此字节中的比特序号来求得是第几页
	mov bx, 8
	sub bx, cx		; bx中是比特序号
	add ax, bx		; 现在ax中是页的序号。最多是8*1024，不超过16位
	xor dx, dx		; dx:ax中是被除数，除以1024得到PDE所在的页目录
	mov bx, 1024	
	div bx			; 商在ax，余数在dx
	and eax, 0000ffffh
	and edx, 0000ffffh
	shl eax, 22
	shl edx, 12
	or eax, edx
	mov dword [PhysicalPageBuf + 4 * edi], eax
	
	pop edx
	pop ebx
	inc edi
	mov eax, dword [num_of_alloc]
	cmp edi, eax
	jb .next_bit
	jmp .one_byte_over

.next_bit:
	shr bl, 1
	loop .2

.one_byte_over:
	pop ecx
	mov eax, dword [num_of_alloc]
	cmp edi, eax
	jb .next_byte
	jmp .finish_alloc_phy
.next_byte:
	inc esi
	loop .1

.finish_alloc_phy:		; 现在已经把找到的可用的物理页放在PhysicalPageBuf中
	mov ax, ds
	mov es, ax
	mov esi, PhysicalPageBuf
	mov edi, LinearPageBuf
	mov ecx, dword [num_of_alloc]

; 下面的过程就是确定要返回的线性地址的过程 ================================================
; 这里使用的是最简单的一个思路，将物理地址直接加一个常数变换为线性地址
; 要使用新的线性地址方案，只需在此处修改，并将要返回的线性地址写入LinearPageBuf缓冲区
.convert_to_Linear:
	lodsd
	add eax, 00800000h		; 这里为了处理简单，要返回的线性地址就是物理地址加上8M
	stosd		; 然后转移到LinearPageBuf，返回给应用程序使用
	loop .convert_to_Linear
; ==================================================================================

	; 下面建立从自定义的线性地址道搜索到的可用物理地址之间的映射
	mov ecx, dword [num_of_alloc]
	mov esi, 0		; 既是LinearPageBuf中的偏移，也是PhysicalPageBuf中的偏移
	mov	ax, SelectorFlatRW
	mov	es, ax
.set_PTE:
	; xchg bx, bx
	mov	edi, cr3	; 页目录基址 PageDirBase0
	and edi, 0fffff000h
	mov ebx, dword [LinearPageBuf + esi]	; ebx中放的是此页的线性地址
	shr ebx, 22		; 高10位，PDE在页目录中的偏移
	mov eax, dword [es: edi + 4 * ebx]	; PDE
	and eax, 0fffff000h		; 页表基址
	mov edi, eax
	mov ebx, dword [LinearPageBuf + esi]
	and ebx, 003ff000h	; 取21...12位，即PTE在页表中的偏移
	shr ebx, 12
	mov eax, [PhysicalPageBuf + esi]	; 要映射到的物理地址
	add eax, PG_P  | PG_USU | PG_RWW	; P位置为1
	mov dword [es: edi + 4 * ebx], eax		; 写入PTE
	add esi, 4		; esi跳到下一个要建立映射的LinearPage/PhysicalPage
	loop .set_PTE

	ret
; -------------------------------------------------------------------------





; Free pages code
; 释放页，参数是要释放页的线性地址，在LinearPageBuf中 ----------------------------
free_pages:
	; 调试语句
	; xchg bx, bx
	; mov eax, BitMap
	; mov eax, PhysicalPageBuf
	; mov eax, LinearPageBuf

	; 首先，找到每个线性地址映射到的物理地址，这个过程同时要修改页表项中的P位
	mov ecx, dword [num_of_alloc]
	mov esi, 0		; LinearPageBuf中的偏移
	mov	ax, SelectorFlatRW
	mov	es, ax
.free_one_Linear:
	; 先找到这个线性地址对应的PTE。以下是寻址过程
	mov	edi, cr3	; 页目录基址 PageDirBase0
	and edi, 0fffff000h
	mov ebx, dword [LinearPageBuf + esi]	; ebx中放的是此页的线性地址
	shr ebx, 22		; 高10位，PDE在页目录中的偏移
	mov edi, dword [es: edi + 4 * ebx]	; PDE
	and edi, 0fffff000h		; 页表基址
	mov ebx, dword [LinearPageBuf + esi]
	and ebx, 003ff000h	; 取21...12位，即PTE在页表中的偏移
	shr ebx, 12
	xchg bx, bx
	mov eax, dword [es: edi + 4 * ebx]		; PTE

	; 处理这个PTE： 1.修改P位 2.找到其映射的物理地址
	sub eax, PG_P		; P位置成0
	mov dword [es: edi + 4 * ebx], eax		; 写回PTE
	and eax, 0fffff000h		; 物理页的基址

	; 将此物理页在位图中的对应位置为0
	mov edx, eax
	shr edx, 16		; 被除数高16位在dx中，低16位在ax中
	mov bx, 1000h	; 一个页的大小是4k
	div bx			; 商在ax中，这里一定没有余数，因为页是从0开始顺序划分的
	mov dx, 0
	mov bx, 8		; 计算这个物理块对应在位图的哪个位上
	div bx			; 商在ax中，余数在dx中
	mov bl, 80h
	push ecx
	mov cl, dl
	shr bl, cl
	pop ecx
	xor bl, 0ffh
	mov di, ax
	mov bh, byte [BitMap + di]
	and bh, bl
	mov byte [BitMap + di], bh
	
	add esi, 4		; esi跳到下一个要释放的LinearPage
	loop .free_one_Linear

	xchg bx, bx
	ret
; -------------------------------------------------------------------------

