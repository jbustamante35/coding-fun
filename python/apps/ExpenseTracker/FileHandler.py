# Module for reading and writing Expense object details
from __future__ import print_function
from Expense import Expense

def expensesFromFile(fin, delim):
    flines = fin.readlines()
    exps = []
    n = 0
    for fline in flines:
        fline.rstrip()
        print('in: {:s}'.format(fline), end='')
        split_line = fline.split(delim)
        exps.append(makeExpense(split_line))
        n += 1
    return exps

def makeExpense(split_line):
    print('split: {:s}'.format(split_line), end='')
    name = split_line[0]
    cost = float(split_line[1])
    freq = split_line[2]
    description = split_line[len(split_line)-1]
    exp = Expense(name, description, 'noCategory', cost, freq)
    exp.calculateMonthly()
    return exp

def write2file(exp, fout):
    out = exp.printExpense()
    fout.write(out)
    return 1

