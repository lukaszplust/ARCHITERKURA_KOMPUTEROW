#include <stdio.h>

int* merge_reversed(int tab1[], int tab2[], int n);

#define SIZE 8

int main() {
	int tab1[SIZE], tab2[SIZE];

	printf("Podaj elementy 1 tablicy : ");
	for (int i = 0; i < SIZE; i++) {
		scanf_s("%d", &tab1[i]);
	}
	printf("\nPodaj elementy 2 tablicy : ");
	for (int i = 0; i < SIZE; i++) {
		scanf_s("%d", &tab2[i]);
	}
	printf("\nTablica wyjsciowa : \n");

	int* tab3 = merge_reversed(tab1, tab2, SIZE);

	if (tab3 == 0) {
		printf("Blad!\n");
		return -1;
	}

	for (int i = 0; i < SIZE * 2; i++) {
		printf_s("%d ", tab3[i]);
	}

	return 0;
}
