
org	0100h

	mov	ax, 0B800h
	mov	gs, ax
	mov	ah, 0Fh				; 0000: 黑底    1111: 白字
	mov	al, 'H'

	mov	[gs:((80 * 10 + 70) * 2)], ax	; 屏幕第 10 行, 第 70 列。

	jmp	$		; Start
