global KeyBoardHandler
global ClockHandler
global UeserIntHandler

UeserIntHandler:
	push eax
	mov	ah, 0Ch				; 0000: 黑底    1100: 红字
	mov	al, 'I'
	mov	[gs:((80 * 1 + 39) * 2)], ax	; 屏幕第 6 行, 第 20 列。
	
	mov	al, 20h
	out	20h, al				; 发送 EOI
	pop eax
	iretd



ClockHandler:
	;xchg bx, bx
	push eax
	inc	byte [gs:((80 * 1 + 39) * 2)]	; 屏幕第 6 行, 第 20 列。
	xor ax, ax
	mov al, byte [gs:((80 * 0 + 39) * 2)]	; 回显
	cmp al, 5Ah								; 与Z比较，控制在A-Z之间
	jb  .no
	sub al, 1Ah
	mov	byte [gs:((80 * 1 + 39) * 2)], al	; 屏幕第 6 行, 第 20 列。
.no:
	nop
	nop
	nop
	mov	al, 20h
	out	20h, al				; 发送 EOI
	pop eax
	iretd

KeyBoardHandler:
	;xchg bx, bx
	xor ax, ax 
	in  al, 60h
	cmp al, 0B0h						; 判断是否是B按键抬起时的扫描码
	jne .continue
	mov ah, 0ch
	sub al, 80h
	mov	[gs:((80 * 1 + 39) * 2)], ax	; 屏幕第 7 行, 第 20 列。
	mov	al, 20h
	out	20h, al				; 发送 EOI
	xor ax, ax
	mov	al, 11111101b	; 关闭定时器中断
	out	021h, al	; 主8259, OCW1.
	call	io_delay
	iretd

.continue:
	cmp al, 0B1h						; 判断是否是N按键抬起时的扫描码
	jne .common
	mov ah, 0ch
	sub al, 80h
	mov	[gs:((80 * 1 + 39) * 2)], ax	; 屏幕第 7 行, 第 20 列。
	mov	al, 20h
	xor ax, ax
	mov	al, 11111100b	; 开启定时器中断
	out	021h, al	; 主8259, OCW1.
	mov	al, 20h
	out	20h, al				; 发送 EOI
	call	io_delay
	iretd

.common:
	mov ah, 0ch
	mov	[gs:((80 * 1 + 39) * 2)], ax	; 屏幕第 10 行, 第 73 列。
	mov	al, 20h
	out	20h, al				; 发送 EOI
	iretd

io_delay:
	nop
	nop
	nop
	nop
	ret

