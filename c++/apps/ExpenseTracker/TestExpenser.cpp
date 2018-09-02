#include <iostream>
#include <string>
#include "Expense.hpp"

using namespace std;

int main () {
	Expense exp;
	exp.name = "Netflix";
	exp.description = "Video streaming service";
	exp.total_cost = 9.99;
	exp.payment_period = "monthly";
//exp.monthly_cost = exp.CalculateMonthly;
	return 0;
}

