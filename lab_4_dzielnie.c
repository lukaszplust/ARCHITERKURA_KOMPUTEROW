#include <stdio.h>

int dzielenie(int* dzielna, int** dzielnik);

int main() {
	int b,a, wynik;
	int* wsk = &b;
	b = -10;
	a = -2;

	wynik = dzielenie(&wsk, &a);
	printf("Wynik : %d", wynik);
	return 0;
}
