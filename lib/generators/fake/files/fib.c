#include <stdio.h>

int main(){
	printf("%i\n", fib(36));
	return 0;
}

int fib(int n){
	return n < 2 ? n : fib(n-1) + fib(n-2);
}