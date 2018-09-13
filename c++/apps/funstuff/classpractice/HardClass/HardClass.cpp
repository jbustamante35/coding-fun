#include <iostream>
#include <stdio.h>
#include <string>
#include "HardClass.hpp"

using namespace std;

HardClass::HardClass(string n, char i, double t) {
    name = n;
    payment_interval = i;
    total_paid = t;
}

double HardClass::calculateMonthly() {

    double d = 0;

    switch (payment_interval) {
        case 'y':
            d = 12.00;
            break;

        case 'm':
            d = 1.00;
            break;

        case 'd':
            d = 1.00/30.00;
            break;

        default:
            d = 1.00;
            break;
    }

    monthly = total_paid / d;
    return monthly;
}

void HardClass::setDescription(string desc) {
    description = desc;
}

string HardClass::getName() {
    return name;
}

string HardClass::getDescription() {
    return description;
}

char HardClass::getInterval() {
    return payment_interval;
}

double HardClass::getTotal() {
    return total_paid;
}

double HardClass::getMonthly() {
    return monthly;
}
