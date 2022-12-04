#include <stdio.h>

int mnozenie(int* mnozna, int** mnoznik);

int main() {
	int b,a, wynik;
	int* wsk = &b;
	b = -10;
	a = 2;

	wynik = mnozenie(&wsk, &a);
	printf("Wynik : %d", wynik);
	return 0;
}
