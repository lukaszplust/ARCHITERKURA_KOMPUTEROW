#include <stdio.h>

__int64 suma_kwadratow(__int64 a, __int64 b);

int main() {
	__int64 suma = suma_kwadratow(-100000LL, -2LL);
	printf("Suma kwadratow wynosi : %I64d", suma);

	return 0;
}
