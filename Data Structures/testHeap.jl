#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
using Test
include("Heap.jl")

@testset "Heap Tests" begin
    @testset "Constructor" begin
        @test begin
            h = Heap{Int}()
            h.data == []
        end

        @test begin
            f = (a,b)-> a > b
            h = Heap{Int}(f)
            h.comp == f
        end

        @test begin
            h = Heap{Int}(collect(1:5))
            h.data == [1, 2, 3, 4, 5]
        end
    end

    @testset "Insert" begin
        @test begin
            h = Heap{Int}()
            insert!(h, 1)
            h.data == [1]
        end

        @test begin
            h = Heap{Int}()
            insert!(h, 1)
            insert!(h, 0)
            h.data == [0, 1]
        end

        @test begin
            h = Heap{Int}([1, 2, 3])
            insert!(h, 0)
            h.data == [0, 1, 3, 2]
        end
    end

    @testset "Root" begin
        @test begin
            h = Heap{Int}()
            insert!(h, 1)
            root(h) == 1
        end

        @test begin
            h = Heap{Int}()
            insert!(h, 1)
            insert!(h, 0)
            root(h) == 0
        end

        @test begin
            h = Heap{Int}([1, 2, 3])
            insert!(h, 0)
            root(h) == 0
        end

        @test_throws ErrorException begin
            h = Heap{Int}()
            root(h)
        end
    end

    @testset "Extract" begin
        @test begin
            h = Heap{Int}()
            insert!(h, 1)
            extract!(h) == 1 &&
            isempty(h)
        end

        @test begin
            h = Heap{Int}()
            insert!(h, 1)
            insert!(h, 0)
            extract!(h) == 0 &&
            root(h) == 1
        end

        @test_throws ErrorException begin
            h = Heap{Int}()
            extract!(h)
        end
    end

    @testset "isempty" begin
        @test begin
            h = Heap{Int}()
            isempty(h)
        end

        @test begin
            h = Heap{Int}()
            insert!(h, 1)
            insert!(h, 0)
            !isempty(h)
        end
    end

end
