#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia

if abspath(PROGRAM_FILE) == @__FILE__
    q = parse(Int, readline(stdin))
    _back = []
    _front = []

    for i=1:q
        t = parse.(Int, split(readline(stdin)))
        if length(t) > 1
            x = t[2]
            push!(_back, x)
        else
            if t[1] == 2
                if (isempty(_front))
                    while !isempty(_back)
                        push!(_front, pop!(_back))
                    end
                end
                pop!(_front)
            elseif t[1] == 3
                if (isempty(_front))
                    while !isempty(_back)
                        push!(_front, pop!(_back))
                    end
                end
                println(last(_front))
            end
        end
    end
end
