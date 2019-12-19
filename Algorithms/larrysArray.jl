#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
function larrysArray(A)
    n = length(A)

    for i = 1:n-2
        # sort indices until the next index is within the first three positions available
        for j = i:n
            if A[j] == i
                while (j > i+2)
                    A[j-2], A[j-1], A[j] = A[j], A[j-2], A[j-1]
                    j = j-2
                end
                break
            end
        end
        # rotate three indices until the next index is correct
        while (A[i] != i)
            A[i], A[i+1], A[i+2] = A[i+2], A[i], A[i+1]
        end
    end

    if A[end] == n
        return "YES"
    else
        return "NO"
    end
end


# Main Function
if abspath(PROGRAM_FILE) == @__FILE__

    t = parse(Int, readline(stdin))

    for i = 1:t
        n = parse(Int, readline(stdin))
        A = parse.(Int, split(readline(stdin)))

        ans = larrysArray(A)

        println(ans)
    end

end
