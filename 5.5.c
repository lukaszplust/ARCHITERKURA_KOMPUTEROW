#include <stdio.h>

void pm_jeden(float* tab1);

int main() {

	float tab1[4] = { 27.5, 143.57, 2100.0, -3.51 };
	
	printf("\n%f %f %f %f\n", tab1[0], tab1[1], tab1[2], tab1[3]);
	pm_jeden(tab1);
	printf("\n%f %f %f %f\n", tab1[0], tab1[1], tab1[2], tab1[3]);

	return 0;
}
