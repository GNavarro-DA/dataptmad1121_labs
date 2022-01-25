import random
import string

def random_strings(a,b,n):
    random_list = []
    for i in range(int(n)):
        long = random.randint(int(a),int(b))
        x =''.join(random.choices(string.ascii_lowercase + string.digits, k=long))
        random_list.append(x)
    return random_list

a = input('Enter minimum string length: ')
b = input('Enter maximum string length: ')
n = input('How many random strings to generate? ')

random_strings(a,b,n)
