#include "stdio.h"
#include "string.h"

void read_func(char* str) {
    char buf[8] = {0};
    printf("Reading string ...\n");
    strcpy(buf, str);
    printf("The string is: %s\n", buf);
    // __asm__ __volatile__("xchg %bx, %bx");
    __asm__ __volatile__("nop");
    __asm__ __volatile__("nop");
    __asm__ __volatile__("nop");
    return;
}

void ovfl_goal(void) {
    printf("\n***** This program has been attacked! *****\n");
    printf("***** STACK OVERFLOW ATTACK SUCCEEDED *****\n");
}

int main(int argc, char **argv){
	char str0[8] = "Hello!";
    char str1[16] = "Hello!Hello!";
    char str2[] = {
        0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
        0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
        0x01, 0x01, 0x01, 0x01, 0x50, 0x10, 0x00, 0x00
    };
    char* strings[] = {str0, str1, str2};
    // 这里假定输入仅为一位数字
    int choice = argv[1][0] - '0';
    if (argc == 1) {
        choice = 0;     // 默认使用str0
    }
    printf("chose str: %d\n", choice);

    // __asm__ __volatile__("xchg %bx, %bx");
    read_func(strings[choice]);
    // ovfl_goal();
	return 0;
}