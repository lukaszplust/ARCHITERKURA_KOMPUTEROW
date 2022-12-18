#include <stdio.h>

void dodaj_tablice(char liczby_A[], char liczby_B[], char liczby_C[]);

int main() {
	char liczby_A[16] = { -128, -127, -126, -125, -124, -123, -122, -121,
	120, 121, 122, 123, 124, 125, 126, 127 };
	char liczby_B[16] = { -3, -3, -3, -3, -3, -3, -3, -3, 3, 3, 3, 3,
	3, 3, 3, 3 };
	char liczby_C[16];

	dodaj_tablice(liczby_A, liczby_B, liczby_C);
	printf("Po dodaniu : \\n");
	for (int i = 0; i < 16; i++) {
		printf("%d ", liczby_C[i]);
	}
	return 0;
}
