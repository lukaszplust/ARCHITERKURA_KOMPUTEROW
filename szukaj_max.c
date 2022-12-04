#include <stdio.h>

int* szukaj_elem_max(int tablica[], int n);

int main() {
	int pomiary[7] = { 12, 43, 28, 32, 85, 18, 5 }, * wsk;
	// ebp+4 = slad,ebp+8 = wskaznik na pomiary, ebp+12=ilosc
	wsk = szukaj_elem_max(pomiary, 7);
	printf("\nElement maksymalny = %d\n", *wsk);
	return 0;
}
