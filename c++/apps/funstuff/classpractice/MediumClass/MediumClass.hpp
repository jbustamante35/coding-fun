#include <stdio.h>
#include <string>

using namespace std;

class MediumClass {
    public:
    //private:
        string name;
        string description;
        double total;
        double monthly;

   // public:
        MediumClass(string n, double t);
        double calculateMonthly();
        string getName();
        void getDescription();
        double getTotal();
        double getMonthly();
};