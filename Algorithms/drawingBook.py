#!/bin/python3

import os
import sys

#
# Complete the pageCount function below.
#
def pageCount(n, p):
    left = p//2
    right = n//2 - p//2
    return min(left, right)

if __name__ == '__main__':
    fptr = sys.stdout

    n = int(input())

    p = int(input())

    result = pageCount(n, p)

    fptr.write(str(result) + '\n')

    fptr.close()
