#include <stdio.h>

int dot_product(int tab1[], int tab2[], int n);

int main() {
	// 1 + 4 + 9 + 16 = 30
	int tab1[4] = { 1, 2, 3, 4 };
	int tab2[4] = { 1, 2, 3, 4 };
	int n = 4;
	int wynik = dot_product(tab1, tab2, 4);
	printf("Wynik iloczynu skalarnego to : %d", wynik);

	return 0;
}
