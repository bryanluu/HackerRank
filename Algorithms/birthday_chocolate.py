#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the birthday function below.
def birthday(s, d, m):
    S = 0
    count = 0
    for i, x in enumerate(s):
        if i<m:
            S += x
        else:
            S -= s[i-m]
            S += x
        if i+1 >= m and S == d:
            count += 1
    return count


if __name__ == '__main__':
    fptr = sys.stdout

    n = int(input().strip())

    s = list(map(int, input().rstrip().split()))

    dm = input().rstrip().split()

    d = int(dm[0])

    m = int(dm[1])

    result = birthday(s, d, m)

    fptr.write(str(result) + '\n')

    fptr.close()
