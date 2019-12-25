#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
function isValid(s::String)
    C = sort!(split(s, "")) # sort string
    n = length(s)
    count = Dict{Char, Int}() # count of chars
    d = Dict{Int, Int}() # number of chars with same count

    for i = 1:n
        count[s[i]] = get(count, s[i], 0) + 1
    end

    most = 0
    mc = 0
    for c = values(count)
        d[c] = get(d, c, 0) + 1
        if d[c] > most
            most = d[c]
            mc = c # count that appears most
        end
    end


    outliers = 0
    for k = keys(count)
        if count[k] != mc
            if count[k] > 1 && count[k] != mc+1
                return false
            else
                if outliers > 0
                    return false
                end
                outliers += 1
            end
        end
    end
    return true
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    s = readline(stdin)

    if (isValid(s))
        println("YES")
    else
        println("NO")
    end
end
