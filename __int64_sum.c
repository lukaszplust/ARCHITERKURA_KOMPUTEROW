#include <stdio.h>

__int64 sum(unsigned int n, ...);

int main() {
	//__int64 suma = sum(5, 1, 2, 3, 4, 5);
	__int64 suma = sum(5, 1000000000000LL, 2LL, 3LL, 4LL, 5LL);
	// __int64 suma = sum(1, -3LL);
	//__int64 suma = sum(3, -3LL, -2LL, -1LL);
	//__int64 suma = sum(3, 3LL, 4LL, 5LL);
	//__int64 suma = sum(0);
	printf("Wynik : %I64d", suma);

	return 0;
}
