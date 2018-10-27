# Class for storing Expense objects
import csv
from Expense import Expense
from FileHandler import FileHandler

# Read list of expenses and create Expense objects
# Calculate monthly costs for each
# Print out details of all Expenses
expensesList = '/home/jbustamante/Documents/coding-fun/data/expenses.csv'
delim        = ','
fin          = open(expensesList, "r")
fout         = open('ExpensesManifest.txt', 'w')
fh           = FileHandler(fin, fout, delim)

# Run program
exps = fh.expensesFromFile(fin, delim)

for exp in exps:
    exp.printExpense()
    fh.write2file(exp, fout)

fh.fin.close()
fh.fout.close()
