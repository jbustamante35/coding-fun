#include <stdio.h>
using namespace std;
int getMean(int numA, int numB, int numC);

int main() {
	int x,y,z,mean;

	x = 12;
	y = 15;
	z = 8;
	mean = getMean(x, y, z);
	printf("Numbers chosen: %d, %d, %d\n", x,y,z);
	printf("Mean of your numbers: %d\n", mean);
	return 0;
}

int getMean(int numA, int numB, int numC) {	//numABC already declared 
	int sum, mean; // Only need to declare non-parameters
	sum = numA + numB + numC;
	mean = sum / 3;	
	return mean;
}