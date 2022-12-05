#include <stdio.h>

__int64 sum_of_squares(__int64* tab1, unsigned int n);

int main() {
	__int64 tab1[3] = { 1000000, 2, -3 };
	__int64 suma = sum_of_squares(tab1, 3);
	printf("Suma kwadratow wynosi : %I64d", suma);

	return 0;
}
