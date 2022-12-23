#include <stdio.h>

void pole_kola(float * pr);

int main()
{
	float r;
	printf("Podaj promien: ");
	scanf_s("%f",&r);
	pole_kola(&r);
	printf("Pole kola wynosi %f\n",r);
	return 0;

}
