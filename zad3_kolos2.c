#include <stdio.h>

char* komunikat(char* tekst);

int main() {
    char* tekst = "cos napisze";
    int dlugosc = 11;
    char* wynik = komunikat(tekst);

    for (int i = 0; i < dlugosc + 5; i++)
    {
        printf("%c", *(wynik+i));
    }
    return 0;
}
