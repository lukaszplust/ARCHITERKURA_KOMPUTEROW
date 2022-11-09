#include <stdio.h>
int szukaj4_max(int d, int a, int b, int c);
int main() {
	int p, x, y, z, wynik;
	printf("\\nProsze podac cztery liczby calkowite ze znakiem: ");
	scanf_s("%d %d %d %d",&p ,&x, &y, &z, 32);
	wynik = szukaj4_max(p, x, y, z);
	printf("\\nSposrod podanych liczb %d ,%d, %d, %d, liczba %d jest najwieksza", p, x,
		y, z, wynik);
	return 0;
}
