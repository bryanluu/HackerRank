#!/bin/python3

import math
import os
import random
import re
import sys

# Complete the hourglassSum function below.
def hourglassSum(arr):
    N = len(arr)
    M = -100

    for i in range(N-2):
        for j in range(N-2):
            Hsum = sum(arr[i][j:j+3] + arr[i+1][j+1:j+2] + arr[i+2][j:j+3])
            if Hsum > M:
                M = Hsum
    return M

if __name__ == '__main__':
    fptr = sys.stdout

    arr = []

    for _ in range(6):
        arr.append(list(map(int, input().rstrip().split())))

    result = hourglassSum(arr)

    fptr.write(str(result) + '\n')

    fptr.close()
