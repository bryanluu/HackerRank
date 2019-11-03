// #include <bits/stdc++.h>
#include <iostream>

using namespace std;

string ltrim(const string &);
string rtrim(const string &);
vector<string> split(const string &);

/*
 * a, b positive integers
 * returns the greatest common divisor of a and b
 * returns -1 if a or b is invalid
 * returns max(|a|, |b|) if a or b equals 0
 */
int getGCD(int a, int b)
{
    if(a < 0 || b < 0)
        return -1;

    if(!a || !b)
        return max(abs(a), abs(b));

    int g = 0, d = 0; // gcd

    while((a % 2 == 0) && (b % 2 == 0))
    {
        a /= 2;
        b /= 2;
        d++;
    }

    while(a != b)
    {
        if(a%2 == 0)
            a /= 2;
        else if(b%2 == 0)
            b /= 2;
        else if(a>b)
            a = (a-b)/2;
        else
            b = (b-a)/2;
    }

    g = a;

    int gcd = g*(1 << d);
    return gcd;
}

/*
 * a, b are positive integers
 * Returns the Lowest Common Multiple (LCM) of a, b
 */
int getLCM(int a, int b)
{
    int lcm = (abs(a)/getGCD(a,b))*abs(b);
    return lcm;
}

/*
 * Complete the 'getTotalX' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts following parameters:
 *  1. INTEGER_ARRAY a
 *  2. INTEGER_ARRAY b
 */

int getTotalX(vector<int> a, vector<int> b) {
    int lcm=a[0], gcd=0;

    // determine the LCM of array a
    int n = a.size();
    for(int i=1; i<n; i++)
    {
        lcm = getLCM(lcm, a[i]);
    }
    // cout << lcm << endl;

    // determine the GCD of array b
    n = b.size();
    for(int i=0; i<n; i++)
    {
        gcd = getGCD(gcd, b[i]);
    }
    // cout << gcd << endl;

    // if lcm isn't a factor of b
    if(gcd%lcm != 0 || gcd < lcm)
        return 0;

    int count = 0;
    for(int i=1; (lcm*i)<=gcd; i++)
    {
        if(gcd%(lcm*i) == 0)
            count++;
    }

    return count;
}

int main()
{
    ofstream fout(getenv("OUTPUT_PATH"));

    string first_multiple_input_temp;
    getline(cin, first_multiple_input_temp);

    vector<string> first_multiple_input = split(rtrim(first_multiple_input_temp));

    int n = stoi(first_multiple_input[0]);

    int m = stoi(first_multiple_input[1]);

    string arr_temp_temp;
    getline(cin, arr_temp_temp);

    vector<string> arr_temp = split(rtrim(arr_temp_temp));

    vector<int> arr(n);

    for (int i = 0; i < n; i++) {
        int arr_item = stoi(arr_temp[i]);

        arr[i] = arr_item;
    }

    string brr_temp_temp;
    getline(cin, brr_temp_temp);

    vector<string> brr_temp = split(rtrim(brr_temp_temp));

    vector<int> brr(m);

    for (int i = 0; i < m; i++) {
        int brr_item = stoi(brr_temp[i]);

        brr[i] = brr_item;
    }

    int total = getTotalX(arr, brr);

    fout << total << "\n";

    fout.close();

    return 0;
}

string ltrim(const string &str) {
    string s(str);

    s.erase(
        s.begin(),
        find_if(s.begin(), s.end(), not1(ptr_fun<int, int>(isspace)))
    );

    return s;
}

string rtrim(const string &str) {
    string s(str);

    s.erase(
        find_if(s.rbegin(), s.rend(), not1(ptr_fun<int, int>(isspace))).base(),
        s.end()
    );

    return s;
}

vector<string> split(const string &str) {
    vector<string> tokens;

    string::size_type start = 0;
    string::size_type end = 0;

    while ((end = str.find(" ", start)) != string::npos) {
        tokens.push_back(str.substr(start, end - start));

        start = end + 1;
    }

    tokens.push_back(str.substr(start));

    return tokens;
}
