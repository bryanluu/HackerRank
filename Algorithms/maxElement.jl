#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia

if abspath(PROGRAM_FILE) == @__FILE__
    N = parse(Int, readline(stdin))
    s = []
    m = []
    for i=1:N
        l = split(readline(stdin))
        if length(l) > 1
            x = parse(Int, l[2])
        end
        q = parse(Int, l[1])
        if q == 1
            append!(s, x)
            if isempty(m) || x >= last(m)
                append!(m, x)
            end
        elseif q == 2
            p = pop!(s)
            if p == last(m)
                pop!(m)
            end
        else
            println(last(m))
        end
    end
end
