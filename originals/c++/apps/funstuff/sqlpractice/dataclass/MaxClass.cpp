#include <iostream>
#include <stdio.h>
#include <string>
#include "MaxClass.hpp"

using namespace std;

MaxClass::MaxClass() {
    name             = "";
    payment_interval = 'm';
    total_paid       = 0.00;
}

MaxClass::MaxClass(string n, char i, double t) {
    name             = n;
    payment_interval = i;
    total_paid       = t;
}

double MaxClass::calculateMonthly() {
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

void MaxClass::setDescription(string desc) {
    description = desc;
}

string MaxClass::getName() {
    return name;
}

string MaxClass::getDescription() {
    return description;
}

char MaxClass::getInterval() {
    return payment_interval;
}

double MaxClass::getTotal() {
    return total_paid;
}

double MaxClass::getMonthly() {
    return monthly;
}

void MaxClass::printExpense(MaxClass ex) {
    cout << 
    "Expense: " << ex.getName() << "\n" << 
    "Desecription: " << ex.getDescription() << "\n" << 
    "Payment Interval: " << ex.getInterval() << "\n" << 
    "Total Paid: " << ex.getTotal() << "\n" << 
    "Calculated Monthly: " << ex.getMonthly() << "\n" << 
    endl;
}

