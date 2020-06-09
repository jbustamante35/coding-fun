#include <stdio.h>

int main() {
	int allValues[6] ={5, 23, 53, -2, 55};
	int maxValue = allValues[0];

	for (int i = 1; i < 5; i++) {
		printf("Current max value is %d\n", maxValue);
		if (allValues[i] > maxValue) 
			maxValue = allValues[i];			
		
	}
	printf("\nYour max value is %d\n", maxValue);
	return 0;
}