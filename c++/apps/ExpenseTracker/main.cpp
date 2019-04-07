#include <iostream>
#include <fstream>
#include <vector>
#include <stdio.h>
#include <string>
#include <unistd.h>
#include "Expense.hpp"

using namespace std;

std::vector<Expense> expensesFromFile(string f, string d);
Expense makeExpense(string l, string d);

int main() {
    string ffile = "/home/jbustamante/Documents/coding-fun/data/expenses.csv";
    string delim = ",";

    std::vector<Expense> expenses = expensesFromFile(ffile, delim);

    for (int n = 0; n < expenses.size(); n++) {
        expenses.at(n).printExpense(expenses.at(n));
    }
}

std::vector<Expense> expensesFromFile(string f, string delim) {
    string line_in;
    int n = 0;
    std::vector<Expense> ex;
    ifstream fin(f);

    if (fin.is_open()) {
        while(getline(fin, line_in)) {
            string currLine = line_in;
            ex.push_back(makeExpense(currLine, delim));
        }

        fin.close();

    }

    else {
        cout <<
        "Unable to open file: " <<
        f <<
        endl;
    }
    return ex;
}

Expense makeExpense(string ln, string delim) {

    auto strt = 0U;
    auto stop = ln.find(delim);
    string tkn[4];
    int t = 0;

    while (stop != string::npos) {
        tkn[t++] = ln.substr(strt, stop - strt);
        strt = stop + delim.length();
        stop = ln.find(delim,strt);
    }

    tkn[t] = ln.substr(strt, stop);

    string nm   = tkn[0];
    double ttl  = atof(tkn[1].c_str());
    char intr   = tkn[2][0];
    string desc = tkn[3];

    Expense expense(nm, intr, ttl);
    expense.setDescription(desc);
    expense.calculateMonthly();
    return expense;
}
