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
	Expense() {
		cout << "Created Expense \n" << endl;
		name = "name";
		description = "description";
		total_cost = 0.00;
		payment_period = "yearly";
		monthly_cost = 0.00;
	}	
};

