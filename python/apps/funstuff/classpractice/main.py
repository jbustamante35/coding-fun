# Class for storing Expense objects
from Expense import Expense

# Read list of expenses and create Expense objects
# Calculate monthly costs for each
# Print out details of all Expenses
expensesList = "/home/jbustamante/Documents/coding-fun/expenses.csv"
delim        = ','

exp = Expense('Groceries', 'Monthly groceries', 'Food', 150, 'm')
exp.calculateMonthly()
exp.printExpense()


def expensesFromFile(fin, delim):

    exps = makeExpense(str, delim)
    return exps

#def makeExpense()
