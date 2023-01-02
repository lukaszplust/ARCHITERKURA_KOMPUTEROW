#include <stdio.h>

float avg_wd(int n, void* tablica, void* wagi);

int main()
{
    float tablica[5] = { 3.14f, 4.2f, 15.39f, 43.2f, 7.0f };
    float wagi[5] = { 1.0f, 1.0f, 1.0f, 1.0f, 1.0f };
    float srednia = avg_wd(5, tablica, wagi);
    printf("Srednia to %f", srednia);

    return 0;
}
