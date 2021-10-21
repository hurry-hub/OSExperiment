; ==========================================
; pmtest8.asm
; 编译方法：nasm pmtest8.asm -o pmtest8.com
; ==========================================

%include	"pm.inc"	; 常量, 宏, 以及一些说明

PageDirBase0		equ	200000h	; 页目录开始地址:	2M
PageTblBase0		equ	201000h	; 页表开始地址:		2M +  4K
PageDirBase1		equ	210000h	; 页目录开始地址:	2M + 64K
PageTblBase1		equ	211000h	; 页表开始地址:		2M + 64K + 4K

LinearAddrDemo	equ	00401000h
ProcFoo		equ	00401000h
ProcBar		equ	00501000h
ProcPagingDemo	equ	00301000h

org	0100h
	jmp	LABEL_BEGIN

[SECTION .gdt]
; GDT
;                           段基址,       段界限, 属性
LABEL_GDT:          Descriptor 0,              0, 0                      ; 空描述符
LABEL_DESC_NORMAL:  Descriptor 0,         0ffffh, DA_DRW                 ; Normal 描述符
LABEL_DESC_FLAT_C:  Descriptor 0,        0fffffh, DA_CR|DA_32|DA_LIMIT_4K; 0~4G
LABEL_DESC_FLAT_RW: Descriptor 0,        0fffffh, DA_DRW|DA_LIMIT_4K     ; 0~4G
LABEL_DESC_CODE32:  Descriptor 0, SegCode32Len-1, DA_CR|DA_32            ; 非一致代码段, 32
LABEL_DESC_CODE16:  Descriptor 0,         0ffffh, DA_C                   ; 非一致代码段, 16
LABEL_DESC_DATA:    Descriptor 0,      DataLen-1, DA_DRW                 ; Data
LABEL_DESC_STACK:   Descriptor 0,     TopOfStack, DA_DRWA|DA_32          ; Stack, 32 位
LABEL_DESC_VIDEO:   Descriptor 0B8000h,   0ffffh, DA_DRW                 ; 显存首地址
; GDT 结束

GdtLen		equ	$ - LABEL_GDT	; GDT长度
GdtPtr		dw	GdtLen - 1	; GDT界限
		dd	0		; GDT基地址

; GDT 选择子
SelectorNormal		equ	LABEL_DESC_NORMAL	- LABEL_GDT
SelectorFlatC		equ	LABEL_DESC_FLAT_C	- LABEL_GDT
SelectorFlatRW		equ	LABEL_DESC_FLAT_RW	- LABEL_GDT
SelectorCode32		equ	LABEL_DESC_CODE32	- LABEL_GDT
SelectorCode16		equ	LABEL_DESC_CODE16	- LABEL_GDT
SelectorData		equ	LABEL_DESC_DATA		- LABEL_GDT
SelectorStack		equ	LABEL_DESC_STACK	- LABEL_GDT
SelectorVideo		equ	LABEL_DESC_VIDEO	- LABEL_GDT
; END of [SECTION .gdt]

[SECTION .data1]	 ; 数据段
ALIGN	32
[BITS	32]
LABEL_DATA:
; 实模式下使用这些符号
; 字符串
_szPMMessage:			db	"In Protect Mode now. ^-^", 0Ah, 0Ah, 0	; 进入保护模式后显示此字符串
_szMemChkTitle:			db	"BaseAddrL BaseAddrH LengthLow LengthHigh   Type", 0Ah, 0	; 进入保护模式后显示此字符串
_szRAMSize			db	"RAM size:", 0
_szReturn			db	0Ah, 0
_sz1				db	"Linear Addr of pages allocated:", 0
_sz2				db	"Freed page:", 0
; 变量
_wSPValueInRealMode		dw	0
_dwMCRNumber:			dd	0	; Memory Check Result
_dwDispPos:			dd	(80 * 2 + 0) * 2	; 屏幕第 1 行, 第 0 列。
_dwMemSize:			dd	0
_ARDStruct:			; Address Range Descriptor Structure
	_dwBaseAddrLow:		dd	0
	_dwBaseAddrHigh:	dd	0
	_dwLengthLow:		dd	0
	_dwLengthHigh:		dd	0
	_dwType:		dd	0
_PageTableNumber		dd	0
_AllocPageBase			dd	0
_num_of_alloc		dd	3

_MemChkBuf:	times	256	db	0
_PhysicalPageBuf: 	times	32 	dd 0		; 这里将会存储找到的可用物理页的基址
_LinearPageBuf:		times	32	dd 0		; 这里存储要返回的线性地址
; 位图。调试可知页表共8张，每个页表有1024个PTE，因此共n个页
; 每页用1位表示分配状态，一共需要8*1024位，即1024字节
; 我们假设1M以后的物理内存才可用，这就是256个物理页的大小。
; 因此我们将位图的前256=8*32位置为1，也就是32个字节
; 剩下的8*992个位，置为0。也就是992个字节
_BitMap:	times	32		db	11111111b
			times	992		db	0

; 保护模式下使用这些符号
szPMMessage		equ	_szPMMessage	- $$
szMemChkTitle		equ	_szMemChkTitle	- $$
szRAMSize		equ	_szRAMSize	- $$
szReturn		equ	_szReturn	- $$
sz1				equ _sz1 - $$
sz2				equ _sz2 - $$
dwDispPos		equ	_dwDispPos	- $$
dwMemSize		equ	_dwMemSize	- $$
dwMCRNumber		equ	_dwMCRNumber	- $$
ARDStruct		equ	_ARDStruct	- $$
	dwBaseAddrLow	equ	_dwBaseAddrLow	- $$
	dwBaseAddrHigh	equ	_dwBaseAddrHigh	- $$
	dwLengthLow	equ	_dwLengthLow	- $$
	dwLengthHigh	equ	_dwLengthHigh	- $$
	dwType		equ	_dwType		- $$
PageTableNumber		equ	_PageTableNumber- $$
AllocPageBase		equ	_AllocPageBase - $$
num_of_alloc	equ	_num_of_alloc - $$

MemChkBuf		equ	_MemChkBuf	- $$
PhysicalPageBuf	equ	_PhysicalPageBuf - $$
LinearPageBuf	equ	_LinearPageBuf - $$
BitMap			equ _BitMap - $$

DataLen			equ	$ - LABEL_DATA
; END of [SECTION .data1]


; 全局堆栈段
[SECTION .gs]
ALIGN	32
[BITS	32]
LABEL_STACK:
	times 512 db 0

TopOfStack	equ	$ - LABEL_STACK - 1

; END of [SECTION .gs]


[SECTION .s16]
[BITS	16]
LABEL_BEGIN:
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	mov	ss, ax
	mov	sp, 0100h

	mov	[LABEL_GO_BACK_TO_REAL+3], ax
	mov	[_wSPValueInRealMode], sp

	; 得到内存数
	mov	ebx, 0
	mov	di, _MemChkBuf
.loop:
	mov	eax, 0E820h
	mov	ecx, 20
	mov	edx, 0534D4150h
	int	15h
	jc	LABEL_MEM_CHK_FAIL
	add	di, 20
	inc	dword [_dwMCRNumber]
	cmp	ebx, 0
	jne	.loop
	jmp	LABEL_MEM_CHK_OK
LABEL_MEM_CHK_FAIL:
	mov	dword [_dwMCRNumber], 0
LABEL_MEM_CHK_OK:

	; 初始化 16 位代码段描述符
	mov	ax, cs
	movzx	eax, ax
	shl	eax, 4
	add	eax, LABEL_SEG_CODE16
	mov	word [LABEL_DESC_CODE16 + 2], ax
	shr	eax, 16
	mov	byte [LABEL_DESC_CODE16 + 4], al
	mov	byte [LABEL_DESC_CODE16 + 7], ah

	; 初始化 32 位代码段描述符
	xor	eax, eax
	mov	ax, cs
	shl	eax, 4
	add	eax, LABEL_SEG_CODE32
	mov	word [LABEL_DESC_CODE32 + 2], ax
	shr	eax, 16
	mov	byte [LABEL_DESC_CODE32 + 4], al
	mov	byte [LABEL_DESC_CODE32 + 7], ah

	; 初始化数据段描述符
	xor	eax, eax
	mov	ax, ds
	shl	eax, 4
	add	eax, LABEL_DATA
	mov	word [LABEL_DESC_DATA + 2], ax
	shr	eax, 16
	mov	byte [LABEL_DESC_DATA + 4], al
	mov	byte [LABEL_DESC_DATA + 7], ah

	; 初始化堆栈段描述符
	xor	eax, eax
	mov	ax, ds
	shl	eax, 4
	add	eax, LABEL_STACK
	mov	word [LABEL_DESC_STACK + 2], ax
	shr	eax, 16
	mov	byte [LABEL_DESC_STACK + 4], al
	mov	byte [LABEL_DESC_STACK + 7], ah

	; 为加载 GDTR 作准备
	xor	eax, eax
	mov	ax, ds
	shl	eax, 4
	add	eax, LABEL_GDT		; eax <- gdt 基地址
	mov	dword [GdtPtr + 2], eax	; [GdtPtr + 2] <- gdt 基地址

	; 加载 GDTR
	lgdt	[GdtPtr]

	; 关中断
	cli

	; 打开地址线A20
	in	al, 92h
	or	al, 00000010b
	out	92h, al

	; 准备切换到保护模式
	mov	eax, cr0
	or	eax, 1
	mov	cr0, eax

	; 真正进入保护模式
	jmp	dword SelectorCode32:0	; 执行这一句会把 SelectorCode32 装入 cs, 并跳转到 Code32Selector:0  处

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LABEL_REAL_ENTRY:		; 从保护模式跳回到实模式就到了这里
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	mov	ss, ax

	mov	sp, [_wSPValueInRealMode]

	in	al, 92h		; ┓
	and	al, 11111101b	; ┣ 关闭 A20 地址线
	out	92h, al		; ┛

	sti			; 开中断

	mov	ax, 4c00h	; ┓
	int	21h		; ┛回到 DOS
; END of [SECTION .s16]


[SECTION .s32]; 32 位代码段. 由实模式跳入.
[BITS	32]

LABEL_SEG_CODE32:
	mov	ax, SelectorData
	mov	ds, ax			; 数据段选择子
	mov	es, ax
	mov	ax, SelectorVideo
	mov	gs, ax			; 视频段选择子

	mov	ax, SelectorStack
	mov	ss, ax			; 堆栈段选择子

	mov	esp, TopOfStack


	; 下面显示一个字符串
	push	szPMMessage
	call	DispStr
	add	esp, 4
	
	push	szMemChkTitle
	call	DispStr
	add	esp, 4

	call	DispMemSize		; 显示内存信息
	call	SetupPaging
	call	DispReturn

	call DispReturn
	push sz1			; _sz1	db	"Linear Addr of pages allocated:", 0
	call DispStr
	add esp, 4
	call DispReturn
	call alloc_pages
	mov ecx, dword [num_of_alloc]
	mov esi, LinearPageBuf

alloc_result:
	mov eax, dword [esi]
	push eax
	call DispInt
	add esp, 4
	add esi, 4
	loop alloc_result
	call DispReturn

	call free_pages

	; 到此停止
	jmp	SelectorCode16:0
; --------------------------------------------------------------------------


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

; 启动分页机制 --------------------------------------------------------------
SetupPaging:
	; 根据内存大小计算应初始化多少PDE以及多少页表
	xor	edx, edx
	mov	eax, [dwMemSize]
	mov	ebx, 400000h	; 400000h = 4M = 4096 * 1024, 一个页表对应的内存大小
	div	ebx
	mov	ecx, eax	; 此时 ecx 为页表的个数，也即 PDE 应该的个数
	test	edx, edx
	jz	.no_remainder
	inc	ecx		; 如果余数不为 0 就需增加一个页表
.no_remainder:
	mov	[PageTableNumber], ecx	; 暂存页表个数

	; 为简化处理, 所有线性地址对应相等的物理地址. 并且不考虑内存空洞.

	; 首先初始化页目录
	mov	ax, SelectorFlatRW
	mov	es, ax
	mov	edi, PageDirBase0	; 此段首地址为 PageDirBase0
	xor	eax, eax
	mov	eax, PageTblBase0 | PG_P  | PG_USU | PG_RWW
.1:
	stosd
	add	eax, 4096		; 为了简化, 所有页表在内存中是连续的.
	loop	.1

	; 再初始化所有页表
	mov	eax, [PageTableNumber]	; 页表个数
	mov	ebx, 1024		; 每个页表 1024 个 PTE
	mul	ebx
	mov	ecx, eax		; PTE个数 = 页表个数 * 1024s
	mov	edi, PageTblBase0	; 此段首地址为 PageTblBase0
	xor	eax, eax
	mov	eax, PG_P  | PG_USU | PG_RWW
.2:
	stosd
	add	eax, 4096		; 每一页指向 4K 的空间
	loop	.2

	mov	eax, PageDirBase0
	mov	cr3, eax
	mov	eax, cr0
	or	eax, 80000000h
	mov	cr0, eax
	jmp	short .3
.3:
	nop

	ret
; 分页机制启动完毕 ----------------------------------------------------------


; 显示内存信息 --------------------------------------------------------------
DispMemSize:
	push	esi
	push	edi
	push	ecx

	mov	esi, MemChkBuf
	mov	ecx, [dwMCRNumber]	;for(int i=0;i<[MCRNumber];i++) // 每次得到一个ARDS(Address Range Descriptor Structure)结构
.loop:					;{
	mov	edx, 5			;	for(int j=0;j<5;j++)	// 每次得到一个ARDS中的成员，共5个成员
	mov	edi, ARDStruct		;	{			// 依次显示：BaseAddrLow，BaseAddrHigh，LengthLow，LengthHigh，Type
.1:					;
	push	dword [esi]		;
	call	DispInt			;		DispInt(MemChkBuf[j*4]); // 显示一个成员
	pop	eax			;
	stosd				;		ARDStruct[j*4] = MemChkBuf[j*4];
	add	esi, 4			;
	dec	edx			;
	cmp	edx, 0			;
	jnz	.1			;	}
	call	DispReturn		;	printf("\n");
	cmp	dword [dwType], 1	;	if(Type == AddressRangeMemory) // AddressRangeMemory : 1, AddressRangeReserved : 2
	jne	.2			;	{
	mov	eax, [dwBaseAddrLow]	;
	add	eax, [dwLengthLow]	;
	cmp	eax, [dwMemSize]	;		if(BaseAddrLow + LengthLow > MemSize)
	jb	.2			;
	mov	[dwMemSize], eax	;			MemSize = BaseAddrLow + LengthLow;
.2:					;	}
	loop	.loop			;}
					;
	call	DispReturn		;printf("\n");
	push	szRAMSize		;
	call	DispStr			;printf("RAM size:");
	add	esp, 4			;
					;
	push	dword [dwMemSize]	;
	call	DispInt			;DispInt(MemSize);
	add	esp, 4			;

	pop	ecx
	pop	edi
	pop	esi
	ret
; ---------------------------------------------------------------------------

%include	"lib.inc"	; 库函数

SegCode32Len	equ	$ - LABEL_SEG_CODE32
; END of [SECTION .s32]


; 16 位代码段. 由 32 位代码段跳入, 跳出后到实模式
[SECTION .s16code]
ALIGN	32
[BITS	16]
LABEL_SEG_CODE16:
	; 跳回实模式:
	mov	ax, SelectorNormal
	mov	ds, ax
	mov	es, ax
	mov	fs, ax
	mov	gs, ax
	mov	ss, ax

	mov	eax, cr0
	and     eax, 7FFFFFFEh          ; PE=0, PG=0
	mov	cr0, eax

LABEL_GO_BACK_TO_REAL:
	jmp	0:LABEL_REAL_ENTRY	; 段地址会在程序开始处被设置成正确的值

Code16Len	equ	$ - LABEL_SEG_CODE16

; END of [SECTION .s16code]
