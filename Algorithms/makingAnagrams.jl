#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
function makingAnagrams(s1::String, s2::String)
    S1 = Set(s1)
    S2 = Set(s2)

    U = intersect(S1, S2)
    d1 = setdiff(S1, S2)
    d2 = setdiff(S2, S1)

    D1 = Dict{Char, Int}()
    D2 = Dict{Char, Int}()

    for c = s1
        D1[c] = get(D1, c, 0) + 1
    end
    for c = s2
        D2[c] = get(D2, c, 0) + 1
    end

    ans = 0
    for c = d1
        ans += D1[c]
    end
    for c = d2
        ans += D2[c]
    end

    for c = U
        ans += abs(D1[c]-D2[c])
    end

    return ans
end


# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    s1 = readline(stdin)
    s2 = readline(stdin)

    ans = makingAnagrams(s1, s2)

    println(ans)
end
