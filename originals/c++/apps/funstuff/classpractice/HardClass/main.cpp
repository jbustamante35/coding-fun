#include <iostream>
#include <stdio.h>
#include <string>
#include "HardClass.hpp"

using namespace std;

void printExpense(HardClass ex);

int main() {
    string yn = "Amazon";
    char yi = 'y';
    double yt = 119.99;
    HardClass amz(yn, yi, yt);
    amz.setDescription("Online shopping service");
    amz.calculateMonthly();

    cout << 
    "Expense: " << amz.getName() << "\n" <<
    "Desecription: " << amz.getDescription() << "\n" << 
    "Total Paid: " << amz.getTotal() << "\n" << 
    "Calculated Monthly: " << amz.getMonthly() << "\n" << 
    endl;


    string mn = "Eagle Heights Rent";
    char mi = 'm';
    double mt = 505.50;
    HardClass eh_rent(mn, mi, mt);
    eh_rent.setDescription("Rent, Utilities, and Parking at Eagle Heights");
    eh_rent.calculateMonthly();

    cout << 
    "Expense: " << eh_rent.getName() << "\n" <<
    "Desecription: " << eh_rent.getDescription() << "\n" << 
    "Total Paid: " << eh_rent.getTotal() << "\n" << 
    "Calculated Monthly: " << eh_rent.getMonthly() << "\n" << 
    endl;


    string dm = "McDonald's";
    char di = 'd';
    double dt = 8.39;
    HardClass mcd(dm, di, dt);
    mcd.setDescription("Glorious fast food");
    mcd.calculateMonthly();

    printExpense(amz);
    printExpense(eh_rent);
    printExpense(mcd);
};

void printExpense(HardClass ex) {
    cout << 
    "Expense: " << ex.getName() << "\n" <<
    "Desecription: " << ex.getDescription() << "\n" << 
    "Payment Interval: " << ex.getInterval() << "\n" <<
    "Total Paid: " << ex.getTotal() << "\n" << 
    "Calculated Monthly: " << ex.getMonthly() << "\n" << 
    endl;
}