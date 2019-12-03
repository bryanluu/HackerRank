#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia

function isOpen(c::Char)
    return c == '(' || c == '{' || c == '['
end

function isClosed(c::Char)
    return c == ')' || c == '}' || c == ']'
end

function getPartner(c::Char)
    if c == '(' return ')' end
    if c == '{' return '}' end
    if c == '[' return ']' end
    if c == ')' return '(' end
    if c == '}' return '{' end
    if c == ']' return '[' end
end

function isBalanced(str::String)
    s = Vector{Char}() # stack
    for c = str
        if isOpen(c)
            push!(s, c)
        elseif isClosed(c)
            if !isempty(s) && getPartner(c) == last(s)
                pop!(s)
            else
                return false
            end
        end
    end

    return isempty(s)
end


if abspath(PROGRAM_FILE) == @__FILE__
    if isempty(ARGS)
        println("Enter brackets expression:")
        expr = readline(stdin)
    else
        expr = join(ARGS, " ")
    end

    println(isBalanced(expr))
end
