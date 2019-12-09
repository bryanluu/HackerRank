#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia

# Solution from https://www.nayuki.io/page/next-lexicographical-permutation-algorithm
function getNextBiggest(w::String)::String
    # length of word
    L = length(w)

    if L == 1
        return "no answer"
    end

    # reverse string and put into array
    s = split(w, "")

    for i = L-1:-1:1
        if s[i] < s[i+1]
            global suffix = i+1
            global pivot = i
            break
        elseif i == 1
            return "no answer"
        end
    end


    for j = L:-1:suffix
        if s[j] > s[pivot]
            s[pivot], s[j] = s[j], s[pivot]
            reverse!(s, suffix)
            ans = join(s, "")
            return ans
        end
    end

    return ans
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    T = parse(Int, readline(stdin))
    for t=1:T
        w = readline(stdin)
        ans = getNextBiggest(w)
        println(ans)
    end
end
