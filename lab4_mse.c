#include <stdio.h>

int mase_lost(int tab1[], int tab2[], int n);

#define SIZE 4
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
	int wynik = mase_lost(tab1, tab2, 4);
	printf("Blad sredniokwadratowy wynosi : %d", wynik);

	return 0;
}
