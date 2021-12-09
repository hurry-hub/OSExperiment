#include "stdio.h"

int main(int argc, char * argv[])
{
    int i, j;
    for (j = 0; j < 4000000; j++) {}
    printf("pang-  ");
    for (i = 0; i < 9; i++) {
        for (j = 0; j < 8000000; j++) {}
        printf("pang-  ");
    }
    return 0;
}