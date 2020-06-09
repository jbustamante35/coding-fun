# -*- coding: utf-8 -*-
# Script to rewrite rent data to a more usable line-by-line format

print("I am working\n")

with open('EagleHeights_RentTotals_raw.txt','r') as infile:

	data = infile.read()
my_list = data.splitlines()
print (my_list[0])
print (my_list[1])
print (my_list[3])
print (my_list[5])
print (my_list[7])

print('\n\n')
print (data[0:400]) 