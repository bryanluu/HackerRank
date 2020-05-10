#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the countingValleys function below.
def countingValleys(n, s):
    lvl = 0
    valleys = 0
    for c in s:
        if c == 'D':
            lvl -= 1
        else:
            lvl += 1
        if lvl == 0 and c == 'U':
            valleys += 1
    return valleys

if __name__ == '__main__':
    fptr = sys.stdout

    n = int(input())

    s = input()

    result = countingValleys(n, s)

    fptr.write(str(result) + '\n')

    fptr.close()
