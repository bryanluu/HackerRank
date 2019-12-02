#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia

function equalStacks(h1, h2, h3)
    c1 = cumsum(reverse(h1))
    c2 = cumsum(reverse(h2))
    c3 = cumsum(reverse(h3))
    c = []
    append!(c, [c1]);
    append!(c, [c2]);
    append!(c, [c3]);

    while(!isempty(c1) && !isempty(c2) && !isempty(c3))
        mi = 0; # max index
        me = 0; # max element
        if(!isempty(c1))
            me = last(c1)
        end

        for i=2:3
            if(!isempty(c[i]) && last(c[i]) < me)
                me = last(c[i])
                mi = i
            end
        end # get minimum of three cumsum lists

        count = 0
        for i=1:3
            if(isempty(c[i]))
                return 0
            elseif(last(c[i]) > me)
                pop!(c[i])
            elseif(last(c[i]) == me)
                count += 1
            end
        end

        if(count == 3)
            return me
        end
    end

    return 0
end

if abspath(PROGRAM_FILE) == @__FILE__
    n1, n2, n3 = parse.(Int, split(readline(stdin)))
    h1 = parse.(Int, split(readline(stdin)))
    h2 = parse.(Int, split(readline(stdin)))
    h3 = parse.(Int, split(readline(stdin)))
    ans = equalStacks(h1, h2, h3)
    println(ans)
end
