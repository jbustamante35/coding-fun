#include <string>
#include <iostream>
#include "Date.h"

class Date {
public:
	Date:Date(int m, int d, int y)
		:month(m), day(d), year(y)
	{

	}

	void printDate() {
		cout << month << "/" << day
			<< "/" << year << endl; 
	}

private:
	int month;
	int day;
	int year;
};