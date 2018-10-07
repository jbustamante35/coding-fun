# Class for storing Expense objects
from Expense import Expense
from FileHandler import *

# Read list of expenses and create Expense objects
# Calculate monthly costs for each
# Print out details of all Expenses
expensesList = '/home/jbustamante/Documents/coding-fun/data/expenses.csv'
delim        = ','

fin = open(expensesList, "r")
fout = open('ExpensesManifest.txt', 'a+')
exps = expensesFromFile(fin, delim)

for exp in exps:
    write2file(exp, fout)

fin.close()
fout.close()
