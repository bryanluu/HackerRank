#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
using Test
include("LinkedList.jl")

function isSorted(llist::LinkedList)
    curr = llist.head
    while(curr != nothing)
        if(curr.next != nothing && curr.data > curr.next.data)
            return false
        end
        curr = curr.next
    end
    return true
end

@testset "LinkedList Tests" begin
    @testset "Constructor" begin
        @test begin
            llist = LinkedList()
            llist.head == nothing
        end
        @test begin
            llist = LinkedList([])
            llist.head == nothing
        end
        @test begin
            data = rand(Int)
            llist = LinkedList([data])
            llist.head.data == data &&
            llist.head.next == nothing
        end
        @test begin
            data = rand(Int, 2)
            llist = LinkedList(data)
            llist.head.data == data[1] &&
            llist.head.next.data == data[2]
        end
        @test begin
            data = "xy"
            llist = LinkedList(data)
            llist.head.data == data[1] &&
            llist.head.next.data == data[2]
        end
        @test begin
            data = rand(Int)
            llist = LinkedList([data]; SLL=false)
            llist.head.data == data &&
            llist.head.next == nothing &&
            llist.head.prev == nothing
        end
        @test begin
            data = rand(Int, 2)
            llist = LinkedList(data; SLL=false)
            llist.head.data == data[1] &&
            llist.head.next.data == data[2] &&
            llist.head == llist.head.next.prev
        end
        @test begin
            data = "ca"
            llist = LinkedList(data; SLL=false)
            llist.head.data == data[1] &&
            llist.head.next.data == data[2] &&
            llist.head == llist.head.next.prev
        end
        @test_throws MethodError begin
            data = [1, "a"]
            llist = LinkedList(data) # inconsistent datatype
        end
        @test_throws MethodError begin
            data = [1, "a"]
            llist = LinkedList(data; SLL=false) # inconsistent datatype
        end
    end

    @testset "Create SLL" begin
        @test begin
            llist = createSLL(nothing)
            llist.head == nothing
        end
        @test begin
            llist = createSLL([])
            llist.head == nothing
        end
        @test begin
            data = rand(Int)
            llist = createSLL([data])
            llist.head.data == data &&
            llist.head.next == nothing
        end
        @test begin
            data = rand(Int, 2)
            llist = createSLL(data)
            llist.head.data == data[1] &&
            llist.head.next.data == data[2]
        end
        @test begin
            data = "ab"
            llist = createSLL(data)
            llist.head.data == data[1] &&
            llist.head.next.data == data[2]
        end
        @test_throws MethodError begin
            data = [1, "a"]
            llist = createSLL(data) # inconsistent datatype
        end
    end

    @testset "Create DLL" begin
        @test begin
            llist = createDLL(nothing)
            llist.head == nothing
        end
        @test begin
            llist = createDLL([])
            llist.head == nothing
        end
        @test begin
            data = rand(Int)
            llist = createDLL([data])
            llist.head.data == data &&
            llist.head.next == nothing &&
            llist.head.prev == nothing
        end
        @test begin
            data = rand(Int, 2)
            llist = createDLL(data)
            llist.head.data == data[1] &&
            llist.head.next.data == data[2] &&
            llist.head == llist.head.next.prev
        end
        @test begin
            data = "xy"
            llist = createDLL(data)
            llist.head.data == data[1] &&
            llist.head.next.data == data[2] &&
            llist.head == llist.head.next.prev
        end
        @test_throws MethodError begin
            data = [1, "a"]
            llist = createDLL(data) # inconsistent datatype
        end
    end

    @testset "Create Sorted SLL" begin
        @test begin
            llist = createSortedSLL(nothing)
            llist.head == nothing
        end
        @test begin
            llist = createSortedSLL([])
            llist.head == nothing
        end
        @test begin
            data = rand(Int)
            llist = createSortedSLL([data])
            llist.head.data == data &&
            llist.head.next == nothing
        end
        @test begin
            data = rand(Int, 5)
            llist = createSortedSLL(data)
            isSorted(llist)
        end
        @test begin
            data = "cat"
            llist = createSortedSLL(data)
            isSorted(llist)
        end
        @test_throws MethodError begin
            data = [1, "a"]
            llist = createSortedSLL(data) # inconsistent datatype
        end
    end

    @testset "Create Sorted DLL" begin
        @test begin
            llist = createSortedDLL(nothing)
            llist.head == nothing
        end
        @test begin
            llist = createSortedDLL([])
            llist.head == nothing
        end
        @test begin
            data = rand(Int)
            llist = createSortedDLL([data])
            llist.head.data == data &&
            llist.head.next == nothing &&
            llist.head.prev == nothing
        end
        @test begin
            data = rand(Int, 5)
            llist = createSortedDLL(data)
            isSorted(llist)
        end
        @test begin
            data = "cat"
            llist = createSortedDLL(data)
            isSorted(llist)
        end
        @test_throws MethodError begin
            data = [1, "a"]
            llist = createSortedDLL(data) # inconsistent datatype
        end
    end

    @testset "Show LinkedList" begin
        @test begin
            llist = LinkedList()
            ans = repr(llist)
            ans == "[* empty *]"
        end
        @test begin
            data = rand(Int)
            llist = LinkedList([data])
            ans = repr(llist)
            ans == "[" * string(data) * "]"
        end
        @test begin
            data = [1, 2, 3]
            llist = LinkedList(data)
            ans = repr(llist)
            ans == "[1->2->3]"
        end
        @test begin
            data = "cat"
            llist = LinkedList(data)
            ans = repr(llist)
            ans == "[c->a->t]"
        end
        @test begin
            data = [1, 2, 3]
            llist = LinkedList(data; SLL=false)
            ans = repr(llist)
            ans == "[1<->2<->3]"
        end
        @test begin
            data = "cat"
            llist = LinkedList(data; SLL=false)
            ans = repr(llist)
            ans == "[c<->a<->t]"
        end
    end

    @testset "Function asVector" begin
        @test begin
            llist = LinkedList()
            ans = asVector(llist)
            ans == []
        end
        @test begin
            data = rand(Int, 3)
            llist = LinkedList(data)
            ans = asVector(llist)
            ans == data
        end
    end

    @testset "Function asString" begin
        @test begin
            llist = LinkedList()
            ans = asString(llist)
            ans == ""
        end
        @test begin
            data = "Hello"
            llist = LinkedList(data)
            ans = asString(llist)
            ans == data
        end
        @test_throws TypeError begin
            data = [1, 2, 3]
            llist = LinkedList(data)
            asString(llist)
        end
    end

    @testset "Sort LinkedList" begin
        @test begin
            data = rand(Int, 5)
            llist = LinkedList(data)
            nlist = sort(llist)
            asVector(nlist) == sort!(data)
        end
        @test begin
            data = rand(Int, 5)
            llist = LinkedList(data; SLL=false)
            nlist = sort(llist)
            asVector(nlist) == sort!(data)
        end
        @test begin
            data = "cat"
            llist = LinkedList(data)
            nlist = sort(llist)
            asString(nlist) == "act"
        end
    end
end
