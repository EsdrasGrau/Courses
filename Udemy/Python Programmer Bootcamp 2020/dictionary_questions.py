#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jun  4 20:09:11 2020

@author: esdras
"""

'''
Question 1
Can you remember how to check if a key exists in a dictionary?
Using the capitals dictionary below write some code to ask the user to input
a country, then check to see if that country is in the dictionary and if it is
print the capital. If not tell the user it's not there.
'''

capitals = {'France':'Paris','Spain':'Madrid','United Kingdom':'London',
            'India':'New Delhi','United States':'Washington DC','Italy':'Rome',
            'Denmark':'Copenhagen','Germany':'Berlin','Greece':'Athens',
            'Bulgaria':'Sofia','Ireland':'Dublin','Mexico':'Mexico City'
            }


# user = input('Please write the name of country to check in the dict.>>>')

# if not user.isalpha():
#     print('Please input only a string')
#     user = input('Which country would you like to check: >>>')

# user = user.title()

# if user in capitals:
#     print(f'The capital of {user} is {capitals[user]}')
# else:
#     print('No data available') 
    
    
'''
Question 2
Write python code that will create a dictionary containing key, value pairs
that represent the first 12 values of the Fibonacci sequence 
i.e {1:0,2:1,3:1,4:2,5:3,6:5,7:8 etc}    
'''

# n = 12
# a = 0
# b = 1 
# # Dict in which to store numbers
# di = dict()

# # Use a for loop to create the sequence, repeat n times
# for i in range(1, n+1):
#     di[i] = a
#     a,b = b,a+b
    
# print(di)


'''
Question 3
Create a dictionary to represent the open, high, low, close share price data 
for 4 imaginary companies. 'Python DS', 'PythonSoft', 'Pythazon' and 'Pybook'
the 4 sets of data are [12.87, 13.23, 11.42, 13.10],[23.54,25.76,21.87,22.33],
[98.99,102.34,97.21,100.065],[203.63,207.54,202.43,205.24]
'''


# companies = ['Python DS', ' PythonSoft', 'Pythazon', 'Pybook']
# keys = ['open', 'high', 'low', 'close']
# prices = [[12.87, 13.23, 11.42, 13.10],[23.54,25.76,21.87,22.33],
# [98.99,102.34,97.21,100.065],[203.63,207.54,202.43,205.24]]
    
# dicto = {}

# for i in range(len(keys)):
#     dicto[companies[i]] =dict(zip(keys,prices[i]))

# print(dicto)    
    


'''
Question 4
Go to the python module web page and find a module that you like. Play with it, 
read the documentation and try to implement it.
'''
    
# import pandas as pd
# help(pd)
    
'''
Question 5
Create a dictoinary containing as keys the letters from A-Z, the values should 
be random numbers created from the random module. Can you draw a bar graph of 
the results?
'''
    
# import random
# import matplotlib.pyplot as plt

# keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
# dicto = dict()

# for e in keys:
#     dicto[e] = random.randint(1,100)
# print(dicto)

# x,y = zip(*dicto.items())
# plt.bar(x,y)

'''
Question 6
Create a dictionary containing 4 suits of 13 cards 
['Ace','2','3','4','5','6','7','8','9','10','Jack','Queen','King']
'''

suits = ['Spades', 'Clubs', 'Hearts', 'Diamonds']
rank = ['Ace','2','3','4','5','6','7','8','9','10','Jack','Queen','King']
    
mazo = dict()

for e in suits:
    mazo[e] = rank
    
print(mazo)
    
    
    
    