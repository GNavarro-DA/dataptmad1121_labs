
import time

numbers = {
    'zero':0, 
    'one':1, 
    'two':2, 
    'three':3, 
    'four':4, 
    'five':5
}
results = {
    0: 'zero',
    1: 'one',
    2: 'two',
    3: 'three',
    4: 'four',
    5: 'five',
    6: 'six',
    7: 'seven',
    8 : 'eight',
    9: 'nine',
    10: 'ten',
    -1: 'negative one', 
    -2: 'negative two', 
    -3: 'negative three',
    -4: 'negative four',
    -5: 'negative five'
}
print('Welcome to this calculator!')
print('It can add and subtract whole numbers from zero to five')
a = input('Please choose your first number (zero to five): ')
b = input('What do you want to do? plus or minus: ')
c = input('Please choose your second number (zero to five): ')

start_time = time.time()
if b == 'plus' and a in numbers.keys() and c in numbers.keys():
    sum = numbers[a] + numbers[c]
    print (a, 'plus', c, 'equals', results[sum])
elif b == 'minus' and a in numbers.keys() and c in numbers.keys():
    difference = numbers[a] - numbers[c]
    print (a, 'minus', c, 'equals', results[difference])
else: 
    print('Sorry, I cannot make the operation.')
end_time= time.time()
total_time = end_time - start_time
print('Time: ', total_time)