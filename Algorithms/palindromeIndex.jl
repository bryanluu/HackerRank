#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
function isPalindrome(s::String)::Bool
    n = length(s)
    half = floor(Int, n/2)

    for i = 1:half
        l = i
        r = n+1-i

        if s[l] != s[r]
            return false
        end
    end
    return true
end

function palindromeIndex(s::String)::Int
    n = length(s)
    half = floor(Int, n/2)

    for i = 1:half
        l = i
        r = n+1-i

        if s[l] != s[r]
            if isPalindrome(s[l+1:r])
                return l-1
            elseif isPalindrome(s[l:r-1])
                return r-1
            else
                return -1
            end
        end
    end

    return -1
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    Q = parse(Int, readline(stdin))

    for q = 1:Q
        s = readline(stdin)

        ans = palindromeIndex(s)
        println(ans)
    end
end
