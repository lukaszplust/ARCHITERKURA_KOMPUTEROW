#include <stdio.h>
#include <stdlib.h>
int isPalindrom(char* string, unsigned int liczba_znakow);

int main()
{
	int wynik;
	//wynik = isPalindrom("rower", 5);
	//wynik = isPalindrom("natan", 5);
	//wynik = isPalindrom("kajak", 5);//wynik=1
	wynik = isPalindrom("korek", 5);//wynik=0
	printf("wynik = %d",wynik);
	return 0;
}
