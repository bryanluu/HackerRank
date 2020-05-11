#!/bin/python3

import os
import sys

#
# Complete the getMoneySpent function below.
#
def getMoneySpent(keyboards, drives, b):
    keyboards = sorted(keyboards, reverse=True)
    drives = sorted(drives, reverse=False)

    s, M = 0, -1

    for i, k in enumerate(keyboards):
        j = 0
        while j < len(drives):
            s = keyboards[i] + drives[j]

            if s > b:
                break

            if s > M:
                M = s

            if M == b:
                return M

            j += 1

    return M


if __name__ == '__main__':
    fptr = sys.stdout

    bnm = input().split()

    b = int(bnm[0])

    n = int(bnm[1])

    m = int(bnm[2])

    keyboards = list(map(int, input().rstrip().split()))

    drives = list(map(int, input().rstrip().split()))

    #
    # The maximum amount of money she can spend on a keyboard and USB drive, or -1 if she can't purchase both items
    #

    moneySpent = getMoneySpent(keyboards, drives, b)

    fptr.write(str(moneySpent) + '\n')

    fptr.close()
