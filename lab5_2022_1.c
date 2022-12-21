#include <stdio.h>
float find_max_range(float v, int alpha);
int main()
{
    int alpha = 30;
    float  v = 10.0;
    float wynik;

    wynik = find_max_range(11.3, 30);
    printf("%f \n", wynik);

    wynik = find_max_range(5.3, 45);
    printf("%f \n", wynik);

}
