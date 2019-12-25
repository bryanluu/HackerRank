#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia

# based on PatrickSJackson's solution
function isValid(s)::Bool
    n = length(s)
    for i = 2:n
        if s[i] == s[i-1]
            return false
        end
    end

    return true
end

function alternate(s)
    n = length(s)
    if n < 2
        return 0
    end

    S = (Set(s))
    chars = []
    for c = S
        append!(chars, c)
    end
    nc = length(chars)
    ans = 0
    for i = 1:nc-1
        for j = i:nc
            c1 = chars[i]
            c2 = chars[j]
            cpy = [c for c in s if c == c1 || c == c2]
            if length(cpy) > ans && isValid(cpy)
                ans = length(cpy)
            end
        end
    end

    return ans
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    l = parse(Int32, strip(readline(stdin)))

    s = readline(stdin)

    result = alternate(s)

    println(result)
end
