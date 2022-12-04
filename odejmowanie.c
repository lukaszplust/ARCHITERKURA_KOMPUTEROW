#include <stdio.h>

int odejmowanie(int** odjemna, int* odjemnik);

int main() {
	int a, b, wynik;
	int* wsk = &a;
	a = 40;
	b = 60;

	wynik = odejmowanie(&wsk, &b);
	printf("Wynik : %d", wynik);
	return 0;
}
