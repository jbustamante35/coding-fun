# Class for storing Expense objects
from getMonthFactor import getMonthFactor

class Expense:
    def __init__(self, nm, desc, ctg, cp, fq):
        self.name = nm
        self.description = desc
        self.category = ctg
        self.cost_paid = cp
        self.frequency = fq
        self.monthly_cost = 0

    def getName(self):
        return self.name
    
    def getDescription(self):
        return self.description
    
    def getCategory(self):
        return self.category
    
    def getCostPaid(self):
        return self.cost_paid
    
    def getFrequency(self):
        return self.frequency
    
    def getMonthlyCost(self):
        return self.monthly_cost

    def calculateMonthly(self):
        fac = getMonthFactor(self.frequency)
        self.monthly_cost = self.cost_paid / fac
        return self.monthly_cost

    def printExpense(self):
        print(
        "Expense: {:s}\n"
        "Description: {:s}\n"
        "Payment Interval: {:s}\n"
        "Total Paid: {:f}\n"
        "Calculated Montly: {:f}\n"
        .format(
                self.name, self.description, self.frequency,
                self.cost_paid, self.monthly_cost))
        
        
