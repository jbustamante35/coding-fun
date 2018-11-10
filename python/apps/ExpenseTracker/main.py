# Class for storing Expense objects
from Expense import Expense

class Noun:
    def __init__(self):
        self.person = 'Jim'
        self.place = 'Wisconsin'
        self.thing = 'dog'



arf = Noun()
print(arf.person)

exp = Expense('Groceries', 'Monthly groceries', 'Food', 150, 'm')
name = exp.sayName()
print(name)
f = exp.calculateMonthly()
