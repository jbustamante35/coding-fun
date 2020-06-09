#include <stdio.h>
#include <string>

using namespace std;

class HardClass {
    private:
        string name;
        string description;
        char payment_interval;
        double total_paid;
        double monthly;

    public:
        HardClass(string n, char i, double t);
        double calculateMonthly();
        void setDescription(string desc);
        string getName();
        string getDescription();
        char getInterval();
        double getTotal();
        double getMonthly();
};