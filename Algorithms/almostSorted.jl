#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
function isSorted(A)
    n = length(A)
    if n < 2
        return true
    else
        for i = 2:n
            if A[i] < A[i-1]
                return false
            end
        end
        return true
    end
end

function almostSorted(A)
    n = length(A)
    B = sort(A)
    d = Dict{Int, Int}()

    for i = 1:n
        d[A[i]] = i
    end

    if A == B
        ans = "yes"
        return ans
    else
        for i = 1:n
            if A[i] != B[i]
                l = i
                # index of the element that's supposed to be at i
                r = d[B[d[A[i]]]]

                rev = false
                if isSorted(A[l+1:r-1])
                    A[l], A[r] = A[r], A[l] # swap elements
                else
                    reverse!(A, l, r) # reverse elements
                    rev = true
                end

                if isSorted(A)
                    ans = "yes\n"
                    if !rev
                        ans *= "swap $l $r"
                    else
                        ans *= "reverse $l $r"
                    end
                    return ans
                else
                    ans = "no"
                    return ans
                end
            end
        end
    end
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    n = parse(Int, readline(stdin))
    A = parse.(Int, split(readline(stdin)))

    ans = almostSorted(A)

    println(ans)
end
