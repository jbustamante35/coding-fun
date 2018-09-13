#ifndef Expense
#define Expense

#include <iostream>
#include <string>

class Expense {
	string name;
	double total_cost;
	string payment_period;
	double monthly_cost;
	Expense(int total_cost);
};

#endif