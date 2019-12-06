#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
using Test
include("Stack.jl")

@testset "Stack Tests" begin
    @test begin
        s = Stack{Int}()
        isempty(s)
    end

    @test begin
        s = Stack{Int}()
        push!(s, 0)
        top(s) == 0 &&
        !isempty(s)
    end

    @test begin
        s = Stack{Int}()
        push!(s, 0)
        pop!(s) == 0 &&
        isempty(s)
    end

    @test begin
        s = Stack{Int}()
        push!(s, 0)
        push!(s, 1)
        pop!(s) == 1 &&
        top(s) == 0 &&
        !isempty(s)
    end

    @test_throws ErrorException begin
        s = Stack{Int}()
        pop!(s)
    end

    @test_throws ErrorException begin
        s = Stack{Int}()
        top(s)
    end

end
