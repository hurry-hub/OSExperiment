#include "type.h"
#include "stdio.h"

int main(int argc, char **argv)
{	
	int fd = open("/", O_RDWR);
	//printf("%d\n", fd);
	char buffer[1024];
	read(fd, buffer, 1024);
	int i;
	char *p = buffer;
	for(i = 0; i < 1000; i++){
		if(*(int *)p != 0){
			printf("%s\n", p + 4);
			p += 16;
		}else{
			break;
		}
	}
	return 0;
}
