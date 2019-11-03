//#include <bits/stdc++.h>
#include <iostream>

using namespace std;

void printNumber(const vector<int> &num)
{
    int n = num.size();
    for(int i=n-1; i>=0; i--)
    {
        cout << num[i];
    }
}

void multiply(vector<int> &multiplicand, const int &multiplier)
{
    int result = 0, carry = 0;
    if(multiplicand.empty())
        multiplicand.push_back(1);
    if(multiplier == 1)
        return; // do nothing to the number

    for(int i=0; i<multiplicand.size(); i++)
    {
        result = multiplier*multiplicand[i]+carry;
        multiplicand[i] = result%10;
        carry = result/10;
        if(i+1 == multiplicand.size() && carry > 0)
            multiplicand.push_back(0); // add digit
    }
}

// Complete the extraLongFactorials function below.
void extraLongFactorials(int n) {
    vector<int> result;
    while(n)
    {
        multiply(result, n);
        n--;
    }
    printNumber(result);
}

int main()
{
    int n;
    cin >> n;
    cin.ignore(numeric_limits<streamsize>::max(), '\n');

    extraLongFactorials(n);

    return 0;
}
