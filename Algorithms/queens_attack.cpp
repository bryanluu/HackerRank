// #include <bits/stdc++.h>
#include <iostream>

using namespace std;

vector<string> split_string(string);

void printBoard(int n, int r_q, int c_q, int c_L, int c_R, int r_U, int r_D,
        int r_DL, int c_DL, int r_DR, int c_DR, int r_AL, int c_AL, int r_AR, int c_AR)
{
    for(int r=1; r<=n; r++)
    {
        for(int c=1; c<=n; c++)
        {
            if(c == c_q && r == r_q)
                cout << "o";
            else if(r == r_U && c == c_q)
                cout << "x";
            else if(r == r_D && c == c_q)
                cout << "x";
            else if(r == r_DL && c == c_DL)
                cout << "x";
            else if(r == r_DR && c == c_DR)
                cout << "x";
            else if(r == r_AL && c == c_AL)
                cout << "x";
            else if(r == r_AR && c == c_AR)
                cout << "x";
            else
                cout << "=";
        }
        cout << endl;
    }
}

// Complete the queensAttack function below.
int queensAttack(int n, int k, int r_q, int c_q, vector<vector<int>> obs) {
    int c_L = 0, c_R = n+1; // horizontal limits
    int r_D = 0, r_U = n+1; // vertical limits
    int c_DL = 0, r_DL = n+1, c_DR = n+1, r_DR = 0; // diagonal limits
    int c_AL = 0, r_AL = 0, c_AR = n+1, r_AR = n+1; // anti-diagonal limits

    cout << "Q: " << r_q << "," << c_q << endl;
    cout << "---" << endl;

    for(int i=0; i<k; i++)
    {
        int dV = r_q-obs[i][0], dH = c_q-obs[i][1];
        if(dH && dV) // check if not directly horizontal or vertical
        {
            if(abs(dH) != abs(dV))
                continue; // not on any diagonal
            if(dH > 0) // if obstacle is to the left queen
            {
                if(dV > 0) // if obstacle is on antidiagonal below queen
                {
                    if(dH < c_q - c_AL)
                    {
                        r_AL = obs[i][0];
                        c_AL = obs[i][1];
                        cout << "AL: " << r_AL << "," << c_AL << endl;
                    }
                }
                else // obstacle on diagonal above
                {
                    if(dH < c_q - c_DL)
                    {
                        r_DL = obs[i][0];
                        c_DL = obs[i][1];
                        cout << "DL: " << r_DL << "," << c_DL << endl;
                    }
                }
            }
            else // obstacle is to the right of queen
            {
                if(dV > 0) // if obstacle is on diagonal below queen
                {
                    if(dV < r_q - r_DR)
                    {
                        r_DR = obs[i][0];
                        c_DR = obs[i][1];
                        cout << "DR: " << r_DR << "," << c_DR << endl;
                    }
                }
                else // obstacle on antidiagonal above
                {
                    if(abs(dV) < r_AR - r_q)
                    {
                        r_AR = obs[i][0];
                        c_AR = obs[i][1];
                        cout << "AR: " << r_AR << "," << c_AR << endl;
                    }
                }
            }
        }
        else
        {
            if(dH)
            {
                if(dH > 0) // obstacle is left of queen
                {
                    c_L = obs[i][1];
                    cout << "L: " << obs[i][0] << "," << c_L << endl;
                }
                else
                {
                    c_R = obs[i][1];
                    cout << "R: " << obs[i][0] << "," << c_R << endl;
                }
            }
            else if(dV)
            {
                if(dV > 0) // obstacle is below queen
                {
                    r_D = obs[i][0];
                    cout << "D: " << r_D << "," << obs[i][1] << endl;
                }
                else
                {
                    r_U = obs[i][0];
                    cout << "U: " << r_U << "," << obs[i][1] << endl;
                }
            }
            else
                return 0;
        }
    }
    cout << "---" << endl;
    cout << c_L << "," << c_R << endl;
    cout << r_U << "," << r_D << endl;
    cout << "(" << r_DL << "," << c_DL << "), (" << r_DR << "," << c_DR << ")" << endl;
    cout << "(" << r_AL << "," << c_AL << "), (" << r_AR << "," << c_AR << ")" << endl;
    // printBoard(n, r_q, c_q, c_L, c_R, r_U, r_D, r_DL, c_DL, r_DR, c_DR,
    //             r_AL, c_AL, r_AR, c_AR);

    int H, V, D, A; // spaces for horizontal, vertical, diagonal, antidiagonal movement
    // calculate spaces
    H = c_R-c_L-2;
    V = r_U-r_D-2;
    D = min(c_q-c_DL, r_DL-r_q) + min(c_DR-c_q, r_q-r_DR) - 2;
    A = min(c_q-c_AL, r_q-r_AL) + min(c_AR-c_q, r_AR-r_q) - 2;
    cout << "---" << endl;
    cout << "H: " << H << ", V: " << V << endl;
    cout << "D: " << D << ", A: " << A << endl;
    return H+D+V+A;
}

int main()
{
    ofstream fout(getenv("OUTPUT_PATH"));

    string nk_temp;
    getline(cin, nk_temp);

    vector<string> nk = split_string(nk_temp);

    int n = stoi(nk[0]);

    int k = stoi(nk[1]);

    string r_qC_q_temp;
    getline(cin, r_qC_q_temp);

    vector<string> r_qC_q = split_string(r_qC_q_temp);

    int r_q = stoi(r_qC_q[0]);

    int c_q = stoi(r_qC_q[1]);

    vector<vector<int>> obstacles(k);
    for (int i = 0; i < k; i++) {
        obstacles[i].resize(2);

        for (int j = 0; j < 2; j++) {
            cin >> obstacles[i][j];
        }

        cin.ignore(numeric_limits<streamsize>::max(), '\n');
    }

    int result = queensAttack(n, k, r_q, c_q, obstacles);

    fout << result << "\n";

    fout.close();

    return 0;
}

vector<string> split_string(string input_string) {
    string::iterator new_end = unique(input_string.begin(), input_string.end(), [] (const char &x, const char &y) {
        return x == y and x == ' ';
    });

    input_string.erase(new_end, input_string.end());

    while (input_string[input_string.length() - 1] == ' ') {
        input_string.pop_back();
    }

    vector<string> splits;
    char delimiter = ' ';

    size_t i = 0;
    size_t pos = input_string.find(delimiter);

    while (pos != string::npos) {
        splits.push_back(input_string.substr(i, pos - i));

        i = pos + 1;
        pos = input_string.find(delimiter, i);
    }

    splits.push_back(input_string.substr(i, min(pos, input_string.length()) - i + 1));

    return splits;
}
