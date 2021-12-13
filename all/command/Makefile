# commands/Makefile

ENTRYPOINT	= 0x1000
HD		= ../80m.img

ASM		= nasm
DASM		= objdump
CC		= gcc
LD		= ld
ASMFLAGS	= -I ../include/ -f elf
CFLAGS		= -I ../include/ -c -fno-builtin -fno-stack-protector -Wall
LDFLAGS		= -Ttext 0x1000
DASMFLAGS	= -D
LIB		= ../lib/orangescrt.a
BIN		= echo pwd inject parity_check_open calculator hello ls ping pang stkovfl game

# All Phony Targets
.PHONY : everything final clean realclean disasm all install

# Default starting position
everything : $(BIN)

install : all clean
	cp ../kernel.bin ./ -v
	tar vcf inst.tar kernel.bin $(BIN)
	dd if=inst.tar of=$(HD) seek=`echo "obase=10;ibase=16;(\`egrep -e '^ROOT_BASE' ../boot/include/load.inc | sed -e 's/.*0x//g'\`+\`egrep -e '#define[[:space:]]*INSTALL_START_SECT' ../include/sys/config.h | sed -e 's/.*0x//g'\`)*200" | bc` bs=1 count=`ls -l inst.tar | awk -F " " '{print $$5}'` conv=notrunc

all : realclean everything install

final : all clean

clean :
	rm -f *.o

realclean :
	rm -f $(BIN) *.o

kernel.bin :
	cp ../kernel.bin ./

start.o : start.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

echo.o: echo.c ../include/type.h ../include/stdio.h
	$(CC) $(CFLAGS) -o $@ $<

echo : echo.o start.o $(LIB)
	$(LD) $(LDFLAGS) -o $@ $?

pwd.o: pwd.c ../include/type.h ../include/stdio.h
	$(CC) $(CFLAGS) -o $@ $<

pwd : pwd.o start.o $(LIB)
	$(LD) $(LDFLAGS) -o $@ $?

inject.o: inject.c ../include/type.h ../include/stdio.h
	$(CC) $(CFLAGS) -o $@ $<

inject : inject.o start.o $(LIB)
	$(LD) $(LDFLAGS) -o $@ $?

parity_check_open.o: parity_check_open.c ../include/my_global.h
	$(CC) $(CFLAGS) -o $@ $<

parity_check_open : parity_check_open.o $(LIB)
	$(LD) $(LDFLAGS) -o $@ $?

calculator.o: calculator.c ../include/type.h ../include/stdio.h
	$(CC) $(CFLAGS) -o $@ $<

calculator : calculator.o start.o $(LIB)
	$(LD) $(LDFLAGS) -o $@ $?

game.o: game.c ../include/type.h ../include/stdio.h
	$(CC) $(CFLAGS) -o $@ $<

game : game.o start.o $(LIB)
	$(LD) $(LDFLAGS) -o $@ $?

hello.o: hello.c ../include/type.h ../include/stdio.h
	$(CC) $(CFLAGS) -o $@ $<

hello : hello.o start.o $(LIB)
	$(LD) $(LDFLAGS) -o $@ $?

ls.o: ls.c ../include/type.h ../include/stdio.h
	$(CC) $(CFLAGS) -o $@ $<

ls : ls.o start.o $(LIB)
	$(LD) $(LDFLAGS) -o $@ $?

ping.o: ping.c ../include/type.h ../include/stdio.h
	$(CC) $(CFLAGS) -o $@ $<

ping : ping.o start.o $(LIB)
	$(LD) $(LDFLAGS) -o $@ $?

pang.o: pang.c ../include/type.h ../include/stdio.h
	$(CC) $(CFLAGS) -o $@ $<

pang : pang.o start.o $(LIB)
	$(LD) $(LDFLAGS) -o $@ $?

stkovfl.o: stkovfl.c ../include/type.h ../include/stdio.h
	$(CC) $(CFLAGS) -o $@ $<

stkovfl : stkovfl.o start.o $(LIB)
	$(LD) $(LDFLAGS) -o $@ $?

dis_stkovfl.asm : stkovfl
	$(DASM) $(DASMFLAGS) $< > $@
