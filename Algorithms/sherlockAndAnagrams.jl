#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
function isAnagram(s1::String, s2::String)::Bool
    # character counter
    chars = Dict{Char, Int}()

    for c = s1
        chars[c] = get(chars, c, 0) + 1
    end

    for c = s2
        chars[c] = get(chars, c, 0) - 1
    end

    for c = keys(chars)
        if chars[c] != 0
            return false
        end
    end
    return true
end

function sherlockAndAnagrams(s::String)::Int
    N = length(s)

    res = 0

    # substrings of length n
    for n = 1:N-1
        #println("$n:")
        for i = 1:N-n
            s1 = s[i:i-1+n]
            for j = i+1:N-n+1
                s2 = s[j:j-1+n]
                #println("$i $j")
                #println("$s1 $s2")
                if isAnagram(s1, s2)
                    res += 1
                end
            end
        end
    end

    return res
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    Q = parse(Int, readline(stdin))

    for q = 1:Q
        s = readline(stdin)

        res = sherlockAndAnagrams(s)
        println(res)
    end
end
