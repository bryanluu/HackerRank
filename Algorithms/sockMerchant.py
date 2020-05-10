#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the sockMerchant function below.
def sockMerchant(n, ar):
    m = {}
    pairs = 0
    for a in ar:
        if a not in m:
            m[a] = 1
        else:
            pairs += m.pop(a)
    return pairs

if __name__ == '__main__':
    fptr = sys.stdout

    n = int(input())

    ar = list(map(int, input().rstrip().split()))

    result = sockMerchant(n, ar)

    fptr.write(str(result) + '\n')

    fptr.close()
