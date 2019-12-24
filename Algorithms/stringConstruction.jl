#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
function stringConstruction(s::String)
    S = Set(s)

    return length(S)
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    N = parse(Int, readline(stdin))

    for n = 1:N
        s = readline(stdin)

        ans = stringConstruction(s)

        println(ans)
    end
end
