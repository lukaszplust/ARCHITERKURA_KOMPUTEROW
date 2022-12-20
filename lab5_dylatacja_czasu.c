#include <stdio.h>

float dylatacja_czasu(unsigned int delta_t_zero,float predkosc);
int main()
{
	//float wynik = dylatacja_czasu(10,10000.0f);
	//float wynik = dylatacja_czasu(10, 200000000.0f);
	float wynik = dylatacja_czasu(60, 270000000.0f);
	printf("\\nWynik = %f", wynik);

	return 0;
}
