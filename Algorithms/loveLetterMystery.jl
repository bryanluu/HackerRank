#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
function loveLetterMystery(s::String)::Int
    n = length(s)
    half = floor(Int, n/2)
    S = [c for c=s] # array of chars
    ans = 0
    for i = 1:half
        while true
            l = S[i]
            r = S[end+1-i]

            if l > r
                S[i] -= 1
                ans += 1
            elseif l < r
                S[end+1-i] -= 1
                ans += 1
            else
                break
            end
        end
    end
    return ans
end


# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    Q = parse(Int, readline(stdin))

    for q = 1:Q
        s = readline(stdin)

        ans = loveLetterMystery(s)

        println(ans)
    end
end
