#include <iostream>
#include <stdio.h>
#include <string>
#include "Expense.hpp"

using namespace std;

Expense::Expense() {
    name             = "";
    payment_interval = 'm';
    total_paid       = 0.00;
}

Expense::Expense(string n, char i, double t) {
    name             = n;
    payment_interval = i;
    total_paid       = t;
}

double Expense::calculateMonthly() {
    double dv = 0;

    switch (payment_interval) {
        case 'y':
            dv = 12.00;
            break;

        case 'm':
            dv = 1.00;
            break;

        case 'd':
            dv = 1.00 / 30.00;
            break;

        default:
            dv = 1.00;
            break;
    }

    monthly = total_paid / dv;
    return monthly;
}

void Expense::setDescription(string desc) {
    description = desc;
}

string Expense::getName() {
    return name;
}

string Expense::getDescription() {
    return description;
}

char Expense::getInterval() {
    return payment_interval;
}

double Expense::getTotal() {
    return total_paid;
}

double Expense::getMonthly() {
    return monthly;
}

void Expense::printExpense(Expense ex) {
    cout <<
    "Expense: " << ex.getName() << "\n" <<
    "Desecription: " << ex.getDescription() << "\n" <<
    "Payment Interval: " << ex.getInterval() << "\n" <<
    "Total Paid: " << ex.getTotal() << "\n" <<
    "Calculated Monthly: " << ex.getMonthly() << "\n" <<
    endl;
}

