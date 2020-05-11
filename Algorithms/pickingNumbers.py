#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'pickingNumbers' function below.
#
# The function is expected to return an INTEGER.
# The function accepts INTEGER_ARRAY a as parameter.
#

def pickingNumbers(a):
    m = [0]*100
    for x in a:
        m[x] += 1
    M = 0
    for i in range(99):
        s = m[i] + m[i+1]
        if s > M:
            M = s

    return M

if __name__ == '__main__':
    fptr = sys.stdout

    n = int(input().strip())

    a = list(map(int, input().rstrip().split()))

    result = pickingNumbers(a)

    fptr.write(str(result) + '\n')

    fptr.close()
