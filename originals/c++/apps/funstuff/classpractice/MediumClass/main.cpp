#include <iostream>
#include <stdio.h>
#include <string>
#include "MediumClass.hpp"

int main() {
    string nm = "Netflix";
    double ttl = 15.00;
    MediumClass med(nm, ttl);
    
    string desc = "Movie and Television streaming service."; 
    med.description = desc;
    med.monthly = med.calculateMonthly();

   cout << 
   "Expense: " << med.name << "\n" <<
   "Description: " << med.description << "\n" <<
   "Total Paid: " << med.total << "\n" <<
   "Calculated Monthly: " << med.monthly << endl; 
}