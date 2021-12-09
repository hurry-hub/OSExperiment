#include "stdio.h"

int main(int argc, char * argv[])
{
    int i, j;
    printf("ping!  ");
    for (i = 0; i < 9; i++) {
        for (j = 0; j < 8000000; j++) {}
        printf("ping!  ");
    }
    return 0;
}