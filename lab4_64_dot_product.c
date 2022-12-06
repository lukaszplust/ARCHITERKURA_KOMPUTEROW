#include <stdio.h>

__int64 dot_product(__int64 tab1[], __int64 tab2[], int n);

int main() {
	__int64 tab1[4] = { 1, 2, 3, 4 };
	__int64 tab2[4] = { 1, 2, 3, 4 };
	int n = 4;
	__int64 wynik = dot_product(tab1, tab2, 4);
	printf("Wynik iloczynu skalarnego to : %I64d", wynik);

	return 0;
}
