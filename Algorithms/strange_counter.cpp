// #include <bits/stdc++.h>
#include <iostream>

using namespace std;


// Complete the strangeCounter function below.
long strangeCounter(long t) {
    long n = log2(1 + (t-1)/3); // cycle number (zero based)
    unsigned long long x = 3*exp2(n+1)-t-2; // worked out by algebra
    return x;
}

int main()
{
    ofstream fout(getenv("OUTPUT_PATH"));

    long t;
    cin >> t;
    cin.ignore(numeric_limits<streamsize>::max(), '\n');

    long result = strangeCounter(t);

    fout << result << "\n";

    fout.close();

    return 0;
}
