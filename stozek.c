#include <stdio.h>

float objetosc_stozka(unsigned int big_r, unsigned int small_r, float h);

int main() {

	float wynik = objetosc_stozka(7, 3, 4.2f);
	printf("\\nWynik = %f", wynik);

	return 0;
}
