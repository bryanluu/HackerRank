#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
using Test
include("postfix.jl")
include("balancedBrackets.jl")

@testset "Postfix" begin
    @testset "Functions" begin
        @test begin
            isOperator("*") && isOperator("/") &&
            isOperator("+") && isOperator("-") &&
            !isOperator("x")
        end
        @test begin
            parseExpression("1 2 + 3 * 2 / 0.5 +") ≈ 5
        end
        @test begin
            expr = infixToPostfix("1 + 2 * 3 / 2 - -1")
            parseExpression(expr) ≈ 5
        end
    end
end

@testset "Balanced Brackets" begin
    @test begin
        isBalanced("({[]})")
    end
    @test begin
        isBalanced("([]())")
    end
    @test begin
        !isBalanced("({}(}")
    end
    @test begin
        !isBalanced("(")
    end
    @test begin
        !isBalanced(")")
    end
    @test begin
        !isBalanced("{[(])}")
    end
end
