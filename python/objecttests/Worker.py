class Worker():    

    raise_amount = 1.04

    def __init__(self, first, last, pay):
        self.first = first
        self.last = last
        self.pay = pay
        self.email = first + '.' + last + '@hotmail.com'

    def fullName(self):
        return '{} {}'.format(self.first, self.last)

    def apply_raise(self):
        self.pay = int(self.pay * self.raise_amount)
        print('Applied raise of %0.3f to %s' % ((Worker.raise_amount/10), self.fullName()))        

    
emp_1 = Worker('Peter', 'Griffin', 50000)
emp_2 = Worker('Bob', 'Ross', 16000)

print(emp_1.fullName(), ':', emp_1.email)
print('Salary: $',emp_1.pay)
emp_1.apply_raise()
print('Salary: $',emp_1.pay)

print('\n')

print(emp_2.fullName(),':', emp_2.email)
print('Salary: $',emp_2.pay)
Worker.raise_amount = 1.10
emp_2.apply_raise()
print('Salary: $',emp_2.pay)

print('\n')

print(emp_1.fullName(), ':', emp_1.email)
print('Salary: $',emp_1.pay)
emp_1.apply_raise()
print('Salary: $',emp_1.pay)