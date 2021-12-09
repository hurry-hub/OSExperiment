#include "stdio.h"
#include "string.h"
#include "type.h"

int my_atoi(const char *s)
{
	int num, i;
	char ch;
	num = 0;
	for (i = 0; i < 6; i++)
	{
		ch = s[i];
		if (ch < '0' || ch > '9')
			break;
		num = num*10 + (ch - '0');
	}
	return num;
}

int main(int argc, char* argv[]) {
	char *operator = "+-*/%";
        char *opt = argv[2];
	int num1 = my_atoi(argv[1]);
	printf("the first number is %d\n", num1);
	int num2 = my_atoi(argv[3]);
	printf("the second number is %d\n", num2);
	int flag = 1;
	int res = 0;

	int choice = 5;
	for (int i = 0; i < 5; i++) {
		if (operator[i] == *opt) {
			choice = i;
			break;
		}
	}
	//printf("%d", choice);

	switch (choice) {
		case 0:	  res = num1 + num2;				break;
		case 1:   res = num1 - num2;				break;
		case 2:   res = num1 * num2;				break;
		case 3:
					if (num2 == 0) {
						printf("error! can't div zero!\n");
						flag = 0;
					} else {
						res = num1 / num2;
					}
					break;
		case 4:	if (num2 == 0) {
						printf("error! can't mod zero!\n");
						flag = 0;
						break;
					} else {
						res = num1 % num2;
					}
					break;
	}
    if (flag == 1) {
		printf("result of the calculator is %d\n", res);
	}

    return 0;
}