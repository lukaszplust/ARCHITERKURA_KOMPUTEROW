#include <stdio.h>

float srednia_harm(float* tablica, unsigned int n);

int main() {
	float tablica[5] = { 1.50f, 3.0f, 4.0f, 10.0f, 15.0f }, wynik;
	unsigned int n = 5;

	wynik = srednia_harm(tablica, n);
	printf("Wynik sredniej harmonicznej to : %f", wynik);

	return 0;
}
