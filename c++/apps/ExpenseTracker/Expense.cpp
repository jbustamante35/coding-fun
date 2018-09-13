#include <iostream>
#include <string>
#include "Expense.hpp"

using namespace std;

class Expense {
	public:
		string name;
		string description;
		double total_cost;
		string payment_period;
		double monthly_cost;
	Expense(int total_cost) {
		cout << "Created Expense \n" << endl;
		name = "name";
		description = "description";
		payment_period = "yearly";
		monthly_cost = 0.00;
	}	
};

