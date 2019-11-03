// #include <bits/stdc++.h>
#include <iostream>

using namespace std;

// Complete the stones function below.
vector<int> stones(int n, int a, int b) {
    n--; // remove the 0 stone
    vector<int> ans;
    if(a == b)
    {
        ans.push_back(a*n);
        return ans;
    }
    int s = min(a,b), l = max(a,b);
    for(int i=s*n; i<=l*n; i+=(l-s))
    {
        ans.push_back(i);
    }
    return ans;
}

int main()
{
    ofstream fout(getenv("OUTPUT_PATH"));

    int T;
    cin >> T;
    cin.ignore(numeric_limits<streamsize>::max(), '\n');

    for (int T_itr = 0; T_itr < T; T_itr++) {
        int n;
        cin >> n;
        cin.ignore(numeric_limits<streamsize>::max(), '\n');

        int a;
        cin >> a;
        cin.ignore(numeric_limits<streamsize>::max(), '\n');

        int b;
        cin >> b;
        cin.ignore(numeric_limits<streamsize>::max(), '\n');

        vector<int> result = stones(n, a, b);

        for (int i = 0; i < result.size(); i++) {
            fout << result[i];

            if (i != result.size() - 1) {
                fout << " ";
            }
        }

        fout << "\n";
    }

    fout.close();

    return 0;
}
