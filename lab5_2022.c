#include <stdio.h>
#include <xmmintrin.h>
__m128 mul_at_once(__m128  one, __m128 two);
int main()
{
    __m128 liczba_X, liczba_Y, wynik;
    liczba_X.m128_i32[0] = 1;
    liczba_X.m128_i32[1] = 3;
    liczba_X.m128_i32[2] = 6;
    liczba_X.m128_i32[3] = 9;

    liczba_Y.m128_i32[0] = 1;
    liczba_Y.m128_i32[1] = 0;
    liczba_Y.m128_i32[2] = 4;
    liczba_Y.m128_i32[3] = 2;

    wynik = mul_at_once(liczba_X, liczba_Y);
    printf("\n%d %d %d %d", wynik.m128_i32[0], wynik.m128_i32[1], wynik.m128_i32[2], wynik.m128_i32[3]);

}
