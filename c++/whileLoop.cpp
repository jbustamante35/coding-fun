#include <stdio.h>
using namespace std;

int main() {
	int counter = 0;
	int myArray[8] = {1,2,3,4,5,6,7,8};

	while (counter < sizeof(myArray)) {
		printf("Counter is at %d\t\t", counter);
		printf("myArray is size %d\n", sizeof(myArray));
		counter++;
	}
	return 0;
}