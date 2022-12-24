#include <stdio.h>

int* kopia_tablicy(int tab1[], unsigned int n);

int main() {
    int tab1[5] = { 5, 4, 3, 2, 1 };
    int* tab2 = kopia_tablicy(tab1, 5);

    for (int i = 0; i < 5; i++) {
        printf(" %d", *(tab2 + i));
    }

    return 0;
}
