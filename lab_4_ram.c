#include <stdio.h>

int pamiec();
int main()
{
	int wynik,zmiana;
	wynik = pamiec();
	zmiana = wynik * 0.0009765625;
	printf("Wynik to: %d",zmiana);
	return 0;
}
