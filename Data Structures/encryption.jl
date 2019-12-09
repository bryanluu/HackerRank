#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia

function encrypt(s::String)::String
    L = length(s)
    rows = floor(Int, sqrt(L))
    cols = ceil(Int, sqrt(L))

    if rows*cols < L
        rows += 1
    end

    ans = ""
    for c = 1:cols
        for r = 1:rows
            i = (r-1)*cols+c
            if i > L
                break
            else
                ans *= s[i]
            end
        end # print a column
        ans *= ' ' # add space after every column
    end

    return ans
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    s = readline(stdin)

    ans = encrypt(s)

    println(ans)
end

