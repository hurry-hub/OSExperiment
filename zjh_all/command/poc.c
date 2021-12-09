#include "stdio.h"
#include "string.h"

void toto(char *input){
	int i;
	char buf[8];
	strcpy(buf, input);
	printf("%s", buf);
	printf("\n");
	if (i)
	fofo();
}
void fofo() {
	printf("this cannot be printed!!\n");
}
int main(int argc, char **argv){
	toto(argv[1]);
	return 0;
}

