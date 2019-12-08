#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia

# Complete the minimumSwaps function below.
function minimumSwaps(arr)
    swaps = 0
    m = min(arr...)
    for i=1:length(arr)-1
        k = m+(i-1) # expected value at index i
        if arr[i] != k
            for j = i+1:length(arr) # loop through remainder of array
                if arr[j] == k
                    arr[i], arr[j] = arr[j], arr[i] # swap i with j
                    swaps += 1
                    break
                end
            end
        end
    end
    return swaps
end

if abspath(PROGRAM_FILE) == @__FILE__
    n = parse(Int, readline(stdin))

    arr = [parse(Int, k) for k in split(readline(stdin))]

    res = minimumSwaps(arr)

    println(res)
end
