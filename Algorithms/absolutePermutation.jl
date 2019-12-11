#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia

function absolutePermutation(n::Int, k::Int)::Vector{Int}
    d = Dict{Int,Int}() # dictionary to keep track of used indices
    P = zeros(Int, n) # array to keep final answer

    for i = 1:n
        l = i-k # lower permutation
        u = i+k # upper permutation
        if 1 <= l <= n && !in(d, l) # if l is valid and unused
            d[l] = i
            P[i] = l
        elseif 1 <= u <= n && !in(d, u) # else if u is valid and unused
            d[u] = i
            P[i] = u
        else # otherwise the P array cannot be constructed
            return Vector{Int}([-1])
        end
    end
    return P
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    T = parse(Int, readline(stdin))
    for t = 1:T
        n, k = parse.(Int, split(readline(stdin)))

        result = absolutePermutation(n, k)

        println(result)
    end
end
