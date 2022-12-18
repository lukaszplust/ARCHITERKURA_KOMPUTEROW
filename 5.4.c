#include <stdio.h>

void int2float(int* calkowite, float* zmienno_przec);

int main() {

	int tablicaCalkowite[2] = { -17, 24 };
	float tablicaZmienno[2];

	int2float(tablicaCalkowite, tablicaZmienno);

	printf("\nKonwersja = %f %f\n", tablicaZmienno[0], tablicaZmienno[1]);

	return 0;
}
