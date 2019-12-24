#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
function gameOfThrones(s::String)
    counter = Dict{Char, Int}()
    for c = s
        counter[c] = get(counter, c, 0) + 1
    end

    singles = 0
    for c = keys(counter)
        if counter[c] % 2 != 0
            if singles == 1
                return false
            else
                singles += 1
            end
        end
    end
    return true
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    s = readline(stdin)
    ans = gameOfThrones(s)

    if ans
        println("YES")
    else
        println("NO")
    end
end
