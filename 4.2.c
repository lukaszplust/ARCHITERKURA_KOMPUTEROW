#include <stdio.h>
int liczba_przeciwna(int* m);
int main() {
	int m = -36;
	liczba_przeciwna(&m);
	printf("\n m = %d", m);
	return 0;
}
