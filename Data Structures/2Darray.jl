#!/Applications/Julia-1.2.app/Contents/Resources/julia/bin/julia

if abspath(PROGRAM_FILE) == @__FILE__
    M = zeros(Int, 6, 6);
    for row = 1:6
        M[:,row] = parse.(Int, split(readline(stdin)));
    end

    # print(M)

    Hmax = typemin(Int)
    for r = 2:4
        for c = 2:4
            H = sum(M[r-1, c-1:c+1] + M[r+1, c-1:c+1]) + M[r, c]
            global Hmax
            if H > Hmax
                Hmax = H
            end
            # print(Hmax)
            # print('\n')
        end
    end
    println(Hmax)
end
