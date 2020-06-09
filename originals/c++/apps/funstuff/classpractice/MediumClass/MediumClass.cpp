#include <iostream>
#include <stdio.h>
#include <string>
#include "MediumClass.hpp"

using namespace std;

MediumClass::MediumClass(string n, double t) : name(n), total(t) { }

double MediumClass::calculateMonthly() {
    return total / 12;
}

string MediumClass::getName() {
    return name;
}

void MediumClass::getDescription() {
   cout << description << endl;
}

double MediumClass::getTotal() {
    return total;
}

double MediumClass::getMonthly () {
    return monthly;
}