class Employee:
	pass

emp_1 = Employee()
emp_2 = Employee()

print(emp_1)
print(emp_2)

emp_1.first = 'Peter'
emp_1.last  = 'Griffin'
emp_1.email = 'PeeTear_Griffon@hotmail.com'
emp_1.pay   = 50000

emp_2.first = 'Bob'
emp_2.last  = 'Ross'
emp_2.email = 'happy_trees1960@aol.com'
emp_2.pay   = 16000

print(emp_1.first)
print(emp_2.first)
