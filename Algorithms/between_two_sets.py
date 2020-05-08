#!/bin/python3

import math
import os
import random
import re
import sys


# a, b are positive integers
# Returns the Greatest Common Denominator (GCD) of a and b
# Returns -1 if a or b is invalid
# Returns max(|a|, |b|) if a or b is 0
def getGCD(a, b):
    if a < 0 or b < 0:
        return -1

    if a == 0 or b == 0:
        return max(abs(a), abs(b))

    g, d = 0, 0

    while((a % 2 == 0) and (b % 2 == 0)):
        a //= 2
        b //= 2
        d += 1

    while(a != b):
        if(a%2 == 0):
            a //= 2
        elif(b%2 == 0):
            b //= 2
        elif(a>b):
            a = (a-b)//2
        else:
            b = (b-a)//2

    g = a

    gcd = g*(1 << d)
    return gcd


# a, b are positive integers
# Returns the Lowest Common Multiple (LCM) of a, b
def getLCM(a, b):
    lcm = (abs(a)//getGCD(a,b))*abs(b)
    return lcm


#
# Complete the 'getTotalX' function below.
#
# The function is expected to return an INTEGER.
# The function accepts following parameters:
#  1. INTEGER_ARRAY a
#  2. INTEGER_ARRAY b
#

def getTotalX(a, b):
    lcm, gcd = a[0], 0

    # determine the LCM of array a
    for x in a[1:]:
        lcm = getLCM(lcm, x)

    # determine the GCD of array b
    for x in b:
        gcd = getGCD(gcd, x)

    # if lcm isn't a factor of b
    if(gcd%lcm != 0 or gcd < lcm):
        return 0

    i, count = 1, 0
    while((lcm*i) <= gcd):
        if(gcd%(lcm*i) == 0):
            count += 1
        i += 1

    return count


if __name__ == '__main__':
    fptr = sys.stdout

    first_multiple_input = input().rstrip().split()

    n = int(first_multiple_input[0])

    m = int(first_multiple_input[1])

    arr = list(map(int, input().rstrip().split()))

    brr = list(map(int, input().rstrip().split()))

    total = getTotalX(arr, brr)

    fptr.write(str(total) + '\n')

    fptr.close()
