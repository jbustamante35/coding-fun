#include <iostream> // library for string and cin
#include <stdio.h> // library for printf
using namespace std; // use for strings and variables

int main() {
	string myName = "";
	string myQuest = "";

	printf("Enter your name: ");
	getline(cin, myName);
	printf("Greetings, %s", myName.c_str());

	printf("What is your quest?\n");
	getline(cin, myQuest);
	printf("Your quest is %s\n", myQuest.c_str());

	return 0;
}