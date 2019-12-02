#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia

function isOperator(op::String)
    return op == "*" || op == "+" || op == "-" || op == "/"
end

function evaluate(x::Number, y::Number, op::String)
    if op == "*"
        return x*y
    elseif op == "/"
        return x/y
    elseif op == "+"
        return x+y
    elseif op == "-"
        return x-y
    else
        error("Invalid operator" * op)
    end
end


function parseExpression(expr::String)
    tokens = split(expr)
    s = Vector{Number}()

    for c = tokens
        c = String(c)
        if isOperator(c)
            y = pop!(s)
            x = pop!(s)
            push!(s, evaluate(x, y, c))
        else
            push!(s, parse(Float64, c))
        end
    end

    return pop!(s)
end


if abspath(PROGRAM_FILE) == @__FILE__
    if isempty(ARGS)
        println("Enter RPN expression:")
        expr = readline(stdin)
    else
        expr = join(ARGS, " ")
    end
    res = parseExpression(expr)

    println("Result: ", res)
end
