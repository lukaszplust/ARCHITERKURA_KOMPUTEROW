#include <stdio.h>

int* replace_below_zero(int tab1[],int n,int value);

#define n 8

int main() {
	int tab2[n], value;

	printf("Podaj elementy 1 tablicy : ");
	for (int i = 0; i < n; i++) {
		scanf_s("%d", &tab2[i]);
	}
	printf("Podaj wartosc do zamiany : ");
	scanf_s("%d", &value);
	printf("\nTablica wyjsciowa : \n");
	int* tab1 = replace_below_zero(tab2, n,value);

	if (tab1 == 0) {
		printf("Blad!\\n");
		return -1;
	}
	for (int i = 0; i < n; i++) {
		printf_s("%d ", tab1[i]);
	}

	return 0;
}
