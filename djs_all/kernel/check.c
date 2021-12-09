#include "type.h"
#include "stdio.h"
#include "const.h"
#include "protect.h"
#include "string.h"
#include "fs.h"
#include "proc.h"
#include "tty.h"
#include "console.h"
#include "global.h"
#include "proto.h"
#include "check.h"



PUBLIC int cal_check(const char *filename,  int byteCount)
{

	// open the file in the Read/Write Mode
	int fd = open(filename, O_RDWR);
	if (fd < 0) {
		fd = open(filename, O_CREAT | O_RDWR);
	}
	if (fd < 0){
		printf("%s file open failed", filename);
		exit(-1);
	}

	// open file success, start to calculate the integrity code
//	printf("    (Check Value Calculating...\n       fd = %d, filename = %s, size = %d)\n", fd, filename, byteCount);
//	char * buf = (char *) malloc(byteCount * sizeof(char));
	char buf[1];
	// read all the bytes in the buf, and do '^' operation, aggregddate all the info into the only-one byte variant "code".
	char code;
    for(int i = 0; i < byteCount; i ++) {
		mylseek(fd, i, SEEK_SET);
		read(fd, buf, 1);
        code = (i == 0) ? buf[0] :(buf[0] ^ code);
    }
    // analyze 8-bit "code"
    code = (code >> 4) ^ (code & 0xF);
    code = (code >> 2) ^ (code & 0x3);
    code = (code >> 1) ^ (code & 0x1);
    // odd check is employed
    // code == 0, even number 1s => return 1
    // code == 1, odd  number 1s => return 0
	
	//free(buf);
	close(fd);

	return (code == 0) ? 1 : 0;
}


PUBLIC int check_parity(const char *filename)
{
	printf("------------------Parity Checking-------------------\n");
    int pos = find_position(filename);
	if (pos == -1){
		printf("No Matched Record Found In The Checktable!\n");
		printf("%s seems not existing the File System. Check your order.\n", filename);
		printf("\n      Parity Failed.\n");
		printf("----------------------------------------------------\n");
		return -1;
	}	
	
    // the record is found, print old code	
	int old_code = check_table[pos].checknum;
	printf("Record:\n     Filename: %s, CheckNum: %d, Length: %d bytes\n", filename, old_code, check_table[pos].byteCount);
	// calculate the current code
	struct stat statbuf;
	if(stat(filename, & statbuf) != 0){
		printf("stat not found\n");
		return -1;
	}	
	int new_code = cal_check(filename, statbuf.st_size); 
	printf("Parity Check:\n     Filename: %s, CheckNum: %d, Length: %d bytes\n", filename, new_code, statbuf.st_size);
	if (new_code != old_code) {
		printf("\n Check Num is not matched!\n");
		printf("It seems that %s has been changed!\n");
		printf("----------------------------------------------------\n");
		return -1;
	}
	if (check_table[pos].byteCount != statbuf.st_size) {
        printf("\n File Length is not matched!\n");
        printf("It seems that %s has been changed!\n");
        printf("----------------------------------------------------\n");
        return -1;
    }


	printf("\n Parity Check Success!\n");
	printf("-------------------------------------------------\n");
	return 1;
}

PUBLIC int find_position(const char *filename)
{
    for(int i = 0; i < NUM_CHECKFILES; i ++) {
        if (check_table[i].used == 0)
                break;
        if (!strcmp(filename, check_table[i].filename))
                return i;
    }

    return -1;

}
