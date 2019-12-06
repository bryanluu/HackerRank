#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
using Test
include("Queue.jl")

@testset "Queue Tests" begin
    @test begin
        q = Queue{Int}()
        isempty(q)
    end

    @test begin
        q = Queue{Int}()
        enqueue!(q, 0)
        front(q) == 0 &&
        !isempty(q)
    end

    @test begin
        q = Queue{Int}()
        enqueue!(q, 0)
        dequeue!(q) == 0 &&
        isempty(q)
    end

    @test begin
        q = Queue{Int}()
        enqueue!(q, 0)
        enqueue!(q, 1)
        dequeue!(q) == 0 &&
        !isempty(q) &&
        front(q) == 1
    end

    @test_throws ErrorException begin
        q = Queue{Int}()
        dequeue!(q)
    end

    @test_throws ErrorException begin
        q = Queue{Int}()
        front(q)
    end

end
