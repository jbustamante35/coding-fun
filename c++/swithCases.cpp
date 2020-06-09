#include <stdio.h>
using namespace std;

int main() {
	int num = 20;

	switch(num) {
		case 10: 
			printf("You chose case 10\n"); 
			break;

		case 20:
			printf("You chose case 20\n"); 
			break;

		case 30:
			printf("You chose case 30\n"); 
			break;

		default:
			printf("You didn't choose anything.\n");
			break;			
		}
		return 0;
}		