#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
function twoStrings(s1::String, s2::String)
    S1 = Set(s1)
    S2 = Set(s2)

    return !isempty(intersect(S1, S2))
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    Q = parse(Int, readline(stdin))

    for q = 1:Q
        s1 = readline(stdin)
        s2 = readline(stdin)

        if twoStrings(s1, s2)
            println("YES")
        else
            println("NO")
        end
    end
end
