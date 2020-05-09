#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the divisibleSumPairs function below.
def divisibleSumPairs(n, k, ar):
    m = {i:0 for i in range(k)}
    for a in ar:
        m[a%k] += 1

    count = 0
    count += (m[0]*(m[0]-1))/2

    i = 1
    while i<= k/2 and i != k-i:
        count += m[i]*m[k-i]
        i += 1

    if (k%2==0):
        count += (m[k/2]*(m[k/2]-1))/2
    return int(count)

if __name__ == '__main__':
    fptr = sys.stdout

    nk = input().split()

    n = int(nk[0])

    k = int(nk[1])

    ar = list(map(int, input().rstrip().split()))

    result = divisibleSumPairs(n, k, ar)

    fptr.write(str(result) + '\n')

    fptr.close()
