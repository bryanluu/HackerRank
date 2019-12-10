#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
function isPresent(G::Array{String, 1}, P::Array{String, 1})
    R = length(G)
    C = length(G[1])
    r = length(P)
    c = length(P[1])

    for i = 1:R-r+1
        for j = 1:C-c+1
            if SubString.(G[i:i+r-1], j, j+c-1) == P
                return "YES"
            end
        end
    end

    return "NO"
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    T = parse(Int, readline(stdin))

    for t = 1:T
        R, C = parse.(Int, split(readline(stdin)))
        G = Array{String, 1}()
        for i = 1:R
            append!(G, [readline(stdin)])
        end
        r, c = parse.(Int, split(readline(stdin)))
        P = Array{String, 1}()
        for i = 1:r
            append!(P, [readline(stdin)])
        end

        ans = isPresent(G, P)
        println(ans)
    end
end


