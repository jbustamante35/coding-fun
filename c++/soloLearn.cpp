#include <iostream>
using namespace std;

int myFun() {
	static int i = 5;
	cout << i;
	return ++i;
}

int main() {
	cout << myFun();
	cout << myFun();
	cout << myFun();

}