# Class for storing Expense objects
from __future__ import division
from getMonthFactor import getMonthFactor

class Expense:
    def __init__(self, nm, desc, ctg, cp, fq):
        self.name = nm
        self.description = desc
        self.category = ctg
        self.cost_paid = cp
        self.frequency = fq
        self.monthly_cost = 0

    def sayName(self):
        print(self.name)
        return self.name

    def calculateMonthly(self):
        fac = getMonthFactor(self.frequency)
        print('freq = {:s} | fac = {:f}'.format(self.frequency, fac))
        return fac

