#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia

if abspath(PROGRAM_FILE) == @__FILE__
    n, d = parse.(Int, split(readline(stdin)))

    # create array
    A = parse.(Int, split(readline(stdin)))

    println()
    println(join([A[((i+d)%n)+1] for i=0:n-1], " "))
end
