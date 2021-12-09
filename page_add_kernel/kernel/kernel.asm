
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                               kernel.asm
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                                                     Forrest Yu, 2005
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

PG_P        EQU 1   ; 页存在属性位
PG_RWR      EQU 0   ; R/W 属性位值, 读/执行
PG_RWW      EQU 2   ; R/W 属性位值, 读/写/执行
PG_USS      EQU 0   ; U/S 属性位值, 系统级
PG_USU      EQU 4   ; U/S 属性位值, 用户级

BaseOfKernelFile    equ  08000h ; KERNEL.BIN 被加载到的位置 ----  段地址
OffsetOfKernelFile  equ      0h ; KERNEL.BIN 被加载到的位置 ---- 偏移地址

BaseOfKernelFilePhyAddr equ BaseOfKernelFile * 10h
KernelEntryPointPhyAddr equ 030400h ; 注意：1、必须与 MAKEFILE 中参数 -Ttext >的值相等!!



SELECTOR_KERNEL_CS	equ	8
SELECTOR_KERNEL_RW  equ 010h 

; 导入函数
extern	cstart
extern	exception_handler
extern	spurious_irq
extern  KeyBoardHandler
extern  ClockHandler
extern  UeserIntHandler
extern 	disp_str
extern  disp_int

; 导入全局变量
extern	gdt_ptr
extern	idt_ptr
extern	disp_pos


[SECTION .data]
ALIGN   32

LABEL_DATA:
_szReturn:			db	0Ah, 0
_sz1	:			db	"Linear Addr of pages allocated:", 0
_sz2	:			db	"Freed page:", 0
_AllocPageBase:			dd	0
_num_of_alloc:		dd	3

_MemChkBuf:	times	256	db	0
_PhysicalPageBuf: 	times	32 	dd 0		; 这里将会存储找到的可用物理页的基址
_LinearPageBuf:		times	32	dd 0		; 这里存储要返回的线性地址
; 位图。调试可知页表共8张，每个页表有1024个PTE，因此共n个页
; 每页用1位表示分配状态，一共需要8*1024位，即1024字节
; 我们假设1M以后的物理内存才可用，这就是256个物理页的大小。
; 因此我们将位图的前256=8*32位置为1，也就是32个字节
; 剩下的8*992个位，置为0。也就是992个字节
_BitMap:	times	64		db	11111111b
			times	960		db	0
_DataLen: dw 0

AllocPageBase		equ	_AllocPageBase ; + BaseOfKernelFilePhyAddr
num_of_alloc	equ	_num_of_alloc   + BaseOfKernelFilePhyAddr


MemChkBuf		equ	_MemChkBuf + BaseOfKernelFilePhyAddr
PhysicalPageBuf	equ	_PhysicalPageBuf  + BaseOfKernelFilePhyAddr
LinearPageBuf	equ	_LinearPageBuf   + BaseOfKernelFilePhyAddr
BitMap			equ _BitMap - $$  + BaseOfKernelFilePhyAddr



[SECTION .bss]
StackSpace		resb	2 * 1024
StackTop:		; 栈顶

[section .text]	; 代码在此

global _start	; 导出 _start

global	divide_error
global	single_step_exception
global	nmi
global	breakpoint_exception
global	overflow
global	bounds_check
global	inval_opcode
global	copr_not_available
global	double_fault
global	copr_seg_overrun
global	inval_tss
global	segment_not_present
global	stack_exception
global	general_protection
global	page_fault
global	copr_error
global  hwint00
global  hwint01
global  hwint02
global  hwint03
global  hwint04
global  hwint05
global  hwint06
global  hwint07
global  hwint08
global  hwint09
global  hwint10
global  hwint11
global  hwint12
global  hwint13
global  hwint14
global  hwint15

_start:
	; 此时内存看上去是这样的（更详细的内存情况在 LOADER.ASM 中有说明）：
	;              ┃                                    ┃
	;              ┃                 ...                ┃
	;              ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃■■■■■■Page  Tables■■■■■■┃
	;              ┃■■■■■(大小由LOADER决定)■■■■┃ PageTblBase
	;    00101000h ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃■■■■Page Directory Table■■■■┃ PageDirBase = 1M
	;    00100000h ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃□□□□ Hardware  Reserved □□□□┃ B8000h ← gs
	;       9FC00h ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃■■■■■■■LOADER.BIN■■■■■■┃ somewhere in LOADER ← esp
	;       90000h ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃■■■■■■■KERNEL.BIN■■■■■■┃
	;       80000h ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃■■■■■■■■KERNEL■■■■■■■┃ 30400h ← KERNEL 入口 (KernelEntryPointPhyAddr)
	;       30000h ┣━━━━━━━━━━━━━━━━━━┫
	;              ┋                 ...                ┋
	;              ┋                                    ┋
	;           0h ┗━━━━━━━━━━━━━━━━━━┛ ← cs, ds, es, fs, ss
	;
	;
	; GDT 以及相应的描述符是这样的：
	;
	;		              Descriptors               Selectors
	;              ┏━━━━━━━━━━━━━━━━━━┓
	;              ┃         Dummy Descriptor           ┃
	;              ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃         DESC_FLAT_C    (0～4G)     ┃   8h = cs
	;              ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃         DESC_FLAT_RW   (0～4G)     ┃  10h = ds, es, fs, ss
	;              ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃         DESC_VIDEO                 ┃  1Bh = gs
	;              ┗━━━━━━━━━━━━━━━━━━┛
	;
	; 注意! 在使用 C 代码的时候一定要保证 ds, es, ss 这几个段寄存器的值是一样的
	; 因为编译器有可能编译出使用它们的代码, 而编译器默认它们是一样的. 比如串拷贝操作会用到 ds 和 es.
	;
	;



	; 把 esp 从 LOADER 挪到 KERNEL
	mov	esp, StackTop	; 堆栈在 bss 段中


    mov dword [disp_pos], 0

    sgdt    [gdt_ptr]   ; cstart() 中将会用到 gdt_ptr
    call    cstart      ; 在此函数中改变了gdt_ptr，让它指向新的GDT
    lgdt    [gdt_ptr]   ; 使用新的GDT

    lidt    [idt_ptr]


	
	; the demonstration of page allocation
	push _szReturn
	call disp_str
	add esp, 4

	push _sz1			; _sz1	db	"Linear Addr of pages allocated:", 0
	call disp_str
	add esp, 4
	push _szReturn
	call disp_str
	add esp, 4
		
	mov ax,  SELECTOR_KERNEL_RW
	mov es, ax 
	mov ds, ax
	mov fs, ax
	mov ss, ax
	

	call alloc_pages
	mov ecx,dword [_num_of_alloc]
	mov esi, _LinearPageBuf


alloc_result:
	mov eax, dword [esi]
	push esi
	push ecx
	push eax
	call disp_int
	add esp, 4
	pop ecx

	push _szReturn
	call disp_str
	add esp, 4

	pop esi
	add esi, 4
	dec ecx
	cmp ecx, 0
	ja alloc_result

	push _szReturn
    call disp_str
    add esp, 4
	
	call free_pages


	mov ah, 0Fh             ; 0000: 黑底    1111: 白字
    mov al, 'K'
    mov [gs:((80 * 1 + 39) * 2)], ax    ;


	jmp	SELECTOR_KERNEL_CS:csinit
csinit:
	sti
	jmp $


; 中断和异常 -- 硬件中断
; ---------------------------------
%macro  hwint_master    1
        push    %1
        call    spurious_irq
        add     esp, 4
        hlt
%endmacro
; ---------------------------------

; 申请页，得到页的线性地址放在LinearPageBuf中 -----------------------------------
alloc_pages:
	; xchg bx, bx
	mov esi, _BitMap
	
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


	mov dword [_PhysicalPageBuf + 4 * edi], eax
	
	pop edx
	pop ebx
	inc edi
	mov eax, dword [_num_of_alloc]

	cmp edi, eax
	jb .next_bit
	jmp .one_byte_over

.next_bit:
	shr bl, 1
	loop .2

.one_byte_over:
	pop ecx
	mov eax, dword [_num_of_alloc]
	cmp edi, eax
	jb .next_byte
	jmp .finish_alloc_phy
.next_byte:
	inc esi
	loop .1

.finish_alloc_phy:		; 现在已经把找到的可用的物理页放在PhysicalPageBuf中
	mov ax, ds
	mov es, ax
	mov esi, _PhysicalPageBuf
	mov edi, _LinearPageBuf
	mov ecx, dword [_num_of_alloc]



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
	mov ecx, dword [_num_of_alloc]
	mov esi, 0		; 既是LinearPageBuf中的偏移，也是PhysicalPageBuf中的偏移
	mov	ax, SELECTOR_KERNEL_RW
	mov	es, ax
.set_PTE:
	; xchg bx, bx
	mov	edi, cr3	; 页目录基址 PageDirBase0
	and edi, 0fffff000h
	mov ebx, dword [_LinearPageBuf + esi]	; ebx中放的是此页的线性地址
	shr ebx, 22		; 高10位，PDE在页目录中的偏移
	mov eax, dword [es: edi + 4 * ebx]	; PDE
	and eax, 0fffff000h		; 页表基址
	mov edi, eax
	mov ebx, dword [_LinearPageBuf + esi]
	and ebx, 003ff000h	; 取21...12位，即PTE在页表中的偏移
	shr ebx, 12
	mov eax, [_PhysicalPageBuf + esi]	; 要映射到的物理地址
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

	; 首先，找到每个线性地址映射到的物理地址，这个过程同时要修改页表项中的P位
	mov ecx, dword [_num_of_alloc]
	mov esi, 0		; LinearPageBuf中的偏移
	mov	ax, SELECTOR_KERNEL_RW
	mov	es, ax
.free_one_Linear:
	; 先找到这个线性地址对应的PTE。以下是寻址过程
	mov	edi, cr3	; 页目录基址 PageDirBase0
	and edi, 0fffff000h
	mov ebx, dword [_LinearPageBuf  + esi]	; ebx中放的是此页的线性地址
	shr ebx, 22		; 高10位，PDE在页目录中的偏移
	mov edi, dword [es: edi + 4 * ebx]	; PDE
	and edi, 0fffff000h		; 页表基址
	mov ebx, dword [_LinearPageBuf  + esi]
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
	; one-time bitmap
	;mov bh, byte [_BitMap + di]
	;and bh, bl
	;mov byte [_BitMap + di], bh
	
	add esi, 4		; esi跳到下一个要释放的LinearPage
	loop .free_one_Linear

	xchg bx, bx
	ret
; -------------------------------------------------------------------------



ALIGN   16
hwint00:                ; Interrupt routine for irq 0 (the clock).
       ; call    ClockHandler
		
		;ret
    push eax
    mov al, byte [gs:((80 * 1 + 39) * 2)]
	add al, 1
	mov byte [gs:((80 * 1 + 39) * 2)], al   ; 屏幕第 6 行, 第 20 列。
    xor ax, ax
    mov al, byte [gs:((80 * 1 + 39) * 2)]   ; 回显
    cmp al, 5Ah                             ; 与Z比较，控制在A-Z之间
    jb  .no
    sub al, 1Ah
    mov byte [gs:((80 * 1 + 39) * 2)], al   ; 屏幕第 6 行, 第 20 列。
.no:
    ;nop
    ;nop
    ;nop
    mov al, 20h
    out 20h, al             ; 发送 EOI
    pop eax
    iretd


ALIGN   16
hwint01:                ; Interrupt routine for irq 1 (keyboard)
;		call KeyBoardHandler
		
;		ret 
    xor ax, ax
    in  al, 60h
    cmp al, 0B0h                        ; 判断是否是B按键抬起时的扫描码
    jne .continue
    mov ah, 0ch
    mov al, 41h
    mov [gs:((80 * 1 + 39) * 2)], al    ; 屏幕第 7 行, 第 20 列。
    mov al, 20h
    out 20h, al             ; 发送 EOI
    xor ax, ax
    mov al, 11111101b   ; 关闭定时器中断
    out 021h, al    ; 主8259, OCW1.
    call    io_delay
    iretd

.continue:
    cmp al, 0B1h                        ; 判断是否是N按键抬起时的扫描码
    jne .common
    mov ah, 0ch
    sub al, 80h
    mov [gs:((80 * 1 + 39) * 2)], al    ; 屏幕第 7 行, 第 20 列。
    mov al, 20h
    xor ax, ax
    mov al, 11111100b   ; 开启定时器中断
    out 021h, al    ; 主8259, OCW1.
    mov al, 20h
    out 20h, al             ; 发送 EOI
    call    io_delay
    iretd

.common:
    mov ah, 0ch
    mov [gs:((80 * 1 + 39) * 2)], ax    ; 屏幕第 10 行, 第 73 列。
    mov al, 20h
	out 20h, al             ; 发送 EOI
    iretd
    
io_delay:
    nop
    nop
    nop
    nop
    ret

ALIGN   16
hwint02:                ; Interrupt routine for irq 2 (cascade!)
        hwint_master    2

ALIGN   16
hwint03:                ; Interrupt routine for irq 3 (second serial)
        hwint_master    3

ALIGN   16
hwint04:                ; Interrupt routine for irq 4 (first serial)
        hwint_master    4

ALIGN   16
hwint05:                ; Interrupt routine for irq 5 (XT winchester)
        hwint_master    5

ALIGN   16
hwint06:                ; Interrupt routine for irq 6 (floppy)
        hwint_master    6

ALIGN   16
hwint07:                ; Interrupt routine for irq 7 (printer)
        hwint_master    7

; ---------------------------------
%macro  hwint_slave     1
        push    %1
        call    spurious_irq
        add     esp, 4
        hlt
%endmacro
; ---------------------------------

ALIGN   16
hwint08:                ; Interrupt routine for irq 8 (realtime clock).
        hwint_slave     8

ALIGN   16
hwint09:                ; Interrupt routine for irq 9 (irq 2 redirected)
        hwint_slave     9

ALIGN   16
hwint10:                ; Interrupt routine for irq 10
        hwint_slave     10

ALIGN   16
hwint11:                ; Interrupt routine for irq 11
        hwint_slave     11

ALIGN   16
hwint12:                ; Interrupt routine for irq 12
        hwint_slave     12

ALIGN   16
hwint13:                ; Interrupt routine for irq 13 (FPU exception)
        hwint_slave     13

ALIGN   16
hwint14:                ; Interrupt routine for irq 14 (AT winchester)
        hwint_slave     14

ALIGN   16
hwint15:                ; Interrupt routine for irq 15
        hwint_slave     15



; 中断和异常 -- 异常
divide_error:
	push	0xFFFFFFFF	; no err code
	push	0		; vector_no	= 0
	jmp	exception
single_step_exception:
	push	0xFFFFFFFF	; no err code
	push	1		; vector_no	= 1
	jmp	exception
nmi:
	push	0xFFFFFFFF	; no err code
	push	2		; vector_no	= 2
	jmp	exception
breakpoint_exception:
	push	0xFFFFFFFF	; no err code
	push	3		; vector_no	= 3
	jmp	exception
overflow:
	push	0xFFFFFFFF	; no err code
	push	4		; vector_no	= 4
	jmp	exception
bounds_check:
	push	0xFFFFFFFF	; no err code
	push	5		; vector_no	= 5
	jmp	exception
inval_opcode:
	push	0xFFFFFFFF	; no err code
	push	6		; vector_no	= 6
	jmp	exception
copr_not_available:
	push	0xFFFFFFFF	; no err code
	push	7		; vector_no	= 7
	jmp	exception
double_fault:
	push	8		; vector_no	= 8
	jmp	exception
copr_seg_overrun:
	push	0xFFFFFFFF	; no err code
	push	9		; vector_no	= 9
	jmp	exception
inval_tss:
	push	10		; vector_no	= A
	jmp	exception
segment_not_present:
	push	11		; vector_no	= B
	jmp	exception
stack_exception:
	push	12		; vector_no	= C
	jmp	exception
general_protection:
	push	13		; vector_no	= D
	jmp	exception
	;add esp, 16
	;iretd
page_fault:
	push	14		; vector_no	= E
	jmp	exception
copr_error:
	push	0xFFFFFFFF	; no err code
	push	16		; vector_no	= 10h
	jmp	exception

exception:
	call	exception_handler
	add	esp, 4*2	; 让栈顶指向 EIP，堆栈中从顶向下依次是：EIP、CS、EFLAGS
	hlt


