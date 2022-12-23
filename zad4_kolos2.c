#include <stdio.h>

int* szukaj_elem_min(int tablica[], int n);

int main() {
    int pomiary[7] = { 1, 2, 3, -18, 5, 6, -17 }, * wsk;

    wsk = szukaj_elem_min(pomiary, 7);
    printf("\nElement minimalny = %d\n", *wsk);

    return 0;
}
