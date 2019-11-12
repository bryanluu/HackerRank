#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'dynamicArray' function below.
#
# The function is expected to return an INTEGER_ARRAY.
# The function accepts following parameters:
#  1. INTEGER n
#  2. 2D_INTEGER_ARRAY queries
#

def dynamicArray(n, queries):
    S = [None]*n
    lastAns = 0
    ans = []
    for q in queries:
        x, y = q[1:]
        if q[0] == 1:
            i = (x^lastAns)%n
            if S[i] is None:
                S[i] = []
            S[i].append(y)
        elif q[0] == 2:
            i = (x^lastAns)%n
            seq = S[i]
            lastAns = seq[y % len(seq)]
            ans.append(lastAns)
        # print(q)
        # print(S)
    return ans

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    first_multiple_input = input().rstrip().split()

    n = int(first_multiple_input[0])

    q = int(first_multiple_input[1])

    queries = []

    for _ in range(q):
        queries.append(list(map(int, input().rstrip().split())))

    result = dynamicArray(n, queries)

    fptr.write('\n'.join(map(str, result)))
    fptr.write('\n')

    fptr.close()
