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

function hasHigherPrecedence(op1::String, op2::String)
    if op1 == "*" || op2 == "/"
        return true
    elseif op1 == "+" || op1 == "-"
        return op2 == "*" || op2 == "/" ? false : true
    end
end

function infixToPostfix(expr::String)
    tokens = split(expr)
    s = Vector{String}()
    res = ""

    for c = tokens
        c = String(c)
        if isOperator(c)
            while(!isempty(s) && last(s) != "(" && hasHigherPrecedence(last(s), c))
                res *= pop!(s)
                res *= " "
            end
            push!(s, c)
        elseif c == "("
            push!(s, c)
        elseif c == ")"
            while(!isempty(s) && last(s) != "(")
                res *= pop!(s)
                res *= " "
            end
            pop!(s)
        else
            res *= c
            res *= " "
        end
    end

    while(!isempty(s))
        res *= pop!(s)
        res *= " "
    end

    return res
end

if abspath(PROGRAM_FILE) == @__FILE__
    if isempty(ARGS)
        println("Enter in-fix expression:")
        expr = readline(stdin)
    else
        expr = join(ARGS, " ")
    end
    expr = infixToPostfix(expr)
    res = parseExpression(expr)

    println("Result: ", res)
end
