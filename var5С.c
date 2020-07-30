#include <stdio.h>
#include <Windows.h>

int main(){
	printf("Please, enter 5 unsigned decimal numbers from 0 to 255:\n");

	unsigned char buf[5];
	for(int i=0; i < 5; i++) {
		scanf("%hhu", &buf[i]);
	}

	HMODULE moduleName = GetModuleHandleW(0);

	unsigned char const1 = *((char*)moduleName);
	unsigned char const2 = *((char*)moduleName + 1);

	for (int i = 0; i < 5; i++) {
		buf[i] = const1 + const2 + buf[i] - (i ^ buf[i]);
	}

	printf ("Result (decimal):\n");

	for(int i = 0; i < 5; i++) {
		printf("%hhu ", buf[i]);
	}
	return(0);
}