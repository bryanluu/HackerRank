#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia

# solution inspired by user delanobgt on HackerRank
function getSurfaceArea(A::Matrix{Int})::Int
    H, W = size(A)
    area = 2*H*W

    for i = 1:H
        for j = 1:W
            # check if visible to North
            if 1 <= i-1 <= H
                area += max(0, A[i,j] - A[i-1,j])
            else
                area += A[i,j]
            end
            # check if visible to South
            if 1 <= i+1 <= H
                area += max(0, A[i,j] - A[i+1,j])
            else
                area += A[i,j]
            end
            # check if visible to West
            if 1 <= j-1 <= W
                area += max(0, A[i,j] - A[i,j-1])
            else
                area += A[i,j]
            end
            # check if visible to East
            if 1 <= j+1 <= W
                area += max(0, A[i,j] - A[i,j+1])
            else
                area += A[i,j]
            end
        end
    end

    return area
end


# Main Function
if abspath(PROGRAM_FILE) == @__FILE__

    H, W = parse.(Int, split(readline(stdin)))

    A = zeros(Int, H, W)
    for r = 1:H
        A[r, :] = parse.(Int, split(readline(stdin)))
    end

    price = getSurfaceArea(A)

    println(price)

end
