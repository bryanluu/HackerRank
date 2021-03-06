#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the birthdayCakeCandles function below.
def birthdayCakeCandles(ar):
    M = -1
    count = 0
    for a in ar:
        if a > M:
            M = a
            count = 1
        elif a == M:
            count += 1

    return count

if __name__ == '__main__':
    fptr = sys.stdout

    ar_count = int(input())

    ar = list(map(int, input().rstrip().split()))

    result = birthdayCakeCandles(ar)

    fptr.write(str(result) + '\n')

    fptr.close()
