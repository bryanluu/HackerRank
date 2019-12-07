#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
include("Heap.jl")

if abspath(PROGRAM_FILE) == @__FILE__
    n, k = parse.(Int, split(readline(stdin)))
    A = parse.(Int, split(readline(stdin)))

    jar = Heap{Int}(A) # make min-heap

    ans = 0
    successful = true

    while(front(jar) < k)
        if(length(jar.data) == 1)
            global successful = false
            break
        end

        first = extract!(jar) # get smallest cookie
        second = extract!(jar) # get second smallest cookie
        insert!(jar, first+2second) # add combined cookie
        global ans += 1
    end

    successful ? println(ans) : println(-1)
end
