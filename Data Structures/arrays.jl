#!/Applications/Julia-1.2.app/Contents/Resources/julia/bin/julia

if abspath(PROGRAM_FILE) == @__FILE__
    N = parse(Int, readline(stdin));
    A = parse.(Int, split(readline(stdin)));
    print(join(A[end:-1:1], " "))
end
