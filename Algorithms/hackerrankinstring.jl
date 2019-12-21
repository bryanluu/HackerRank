#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
import Unicode.lower

function hackerrankinString(s::String)
    # starting index
    start = 0
    # length of string
    n = length(s)
    s = lowercase(s)

    for c = "hackerrank"
        found = false
        for i = start+1:n
            if s[i] == c
                found = true
                start = i
                break
            end
        end
        if !found
            return false
        end
    end
    return true
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    Q = parse(Int, readline(stdin))
    for q = 1:Q
        s = readline(stdin)

        if hackerrankinString(s)
            println("YES")
        else
            println("NO")
        end

    end
end
