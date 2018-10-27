# Module for reading and writing Expense object details
from __future__ import print_function
from Expense import Expense
import csv

class FileHandler:
    def __init__(self, fin, fout, delim):
        self.fin   = fin
        self.fout  = fout
        self.delim = delim

    def expensesFromFile(self, fin, delim):
        flines = fin.readlines()
        exps   = []
        n      = 0
        for fline in flines:
            fline.rstrip()
            #print('in: {:s}'.format(fline), end='')
            split_line = fline.split(delim)
            exps.append(self.makeExpense(split_line))
            n += 1
        return exps

    def makeExpense(self, split_line):
        #print('split: {:s}'.format(split_line), end='')
        name        = split_line[0]
        cost        = float(split_line[1])
        freq        = split_line[2]
        description = split_line[len(split_line)-1]
        exp         = Expense(name, description, 'noCategory', cost, freq)
        exp.calculateMonthly()
        return exp

    def write2file(self, exp, fout):
        fout.open(fout.name, 'a+')
        out = exp.printExpense()
        fout.write(out)
        return 1

