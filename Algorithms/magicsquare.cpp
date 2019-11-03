// #include <bits/stdc++.h>
#include <iostream>

using namespace std;

/*
 * Returns the distance between vectors a and b = [i,j,k] of length 3,
 * where the distance is the absolute difference between each of the elements,
 * summed.
 */
int getDistance(const vector<int> &a, const int &i, const int &j, const int &k)
{
    int sum = 0;
    sum += abs(a[0]-i);
    sum += abs(a[1]-j);
    sum += abs(a[2]-k);
    return sum;
}

// Complete the formingMagicSquare function below.
int formingMagicSquare(vector<vector<int>> s) {
    int M[3][3] = {{8,3,4},{1,5,9},{6,7,2}}; // a unique 3x3 magic square
    int min = 96; // (15*8) - (3*8)

    // compare rows
    int sum[8] = {};
    for(int i=0; i<3; i++)
    {
        sum[0] += getDistance(s[i], M[i][0], M[i][1], M[i][2]);
        sum[1] += getDistance(s[i], M[i][2], M[i][1], M[i][0]);
        sum[2] += getDistance(s[i], M[0][i], M[1][i], M[2][i]);
        sum[3] += getDistance(s[i], M[2][i], M[1][i], M[0][i]);
        sum[4] += getDistance(s[i], M[2-i][0], M[2-i][1], M[2-i][2]);
        sum[5] += getDistance(s[i], M[2-i][2], M[2-i][1], M[2-i][0]);
        sum[6] += getDistance(s[i], M[0][2-i], M[1][2-i], M[2][2-i]);
        sum[7] += getDistance(s[i], M[2][2-i], M[1][2-i], M[0][2-i]);
    }
    for(int i=0; i<8; i++)
    {
        if(sum[i] < min)
            min = sum[i];
        if(!min)
            break;
    }

    return min;
}

int main()
{
    ofstream fout(getenv("OUTPUT_PATH"));

    vector<vector<int>> s(3);
    for (int i = 0; i < 3; i++) {
        s[i].resize(3);

        for (int j = 0; j < 3; j++) {
            cin >> s[i][j];
        }

        cin.ignore(numeric_limits<streamsize>::max(), '\n');
    }

    int result = formingMagicSquare(s);

    fout << result << "\n";

    fout.close();

    return 0;
}
