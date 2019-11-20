#!/Applications/Julia-1.2.app/Contents/Resources/julia/bin/julia

if abspath(PROGRAM_FILE) == @__FILE__
    N, Q = parse.(Int, split(readline(stdin)))
    # println(N, " ", Q)

    # create array of sequences
    A = [[] for i=1:N]
    la = 0
    for q=1:Q
        t, x, y = parse.(Int, split(readline(stdin)))
        x += 1

        global la
        i = ((x+la) % N)+1
        if t == 1
            append!(A[i], y)
        elseif t == 2
            la = A[i][(y % length(A[i]))+1]
            println()
            println(la)
        end
    end
end
