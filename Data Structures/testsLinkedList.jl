#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
using Test
include("LinkedList.jl")

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

    @testset "Function isSorted" begin
        @test begin
            llist = LinkedList([1, 2, 3])
            isSorted(llist)
        end
        @test begin
            llist = LinkedList([4, 2, 3])
            !isSorted(llist)
        end
        @test begin
            llist = LinkedList([1, 2, 2, 3])
            isSorted(llist)
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

    @testset "Insert at tail" begin
        @test begin
            llist = LinkedList()
            data = rand(Int)
            insertAtTail!(llist, data)
            llist.head.data == data
        end
        @test begin
            llist = LinkedList([1, 2])
            data = rand(Int)
            insertAtTail!(llist, data)
            llist.head.data == 1 &&
            llist.head.next.data == 2 &&
            llist.head.next.next.data == data
        end
    end

    @testset "Insert at head" begin
        @test begin
            llist = LinkedList()
            data = rand(Int)
            insertAtHead!(llist, data)
            llist.head.data == data
        end
        @test begin
            llist = LinkedList([1, 2])
            data = rand(Int)
            insertAtHead!(llist, data)
            llist.head.data == data &&
            llist.head.next.data == 1 &&
            llist.head.next.next.data == 2
        end
    end

    @testset "Insert at pos" begin
        @test begin
            llist = LinkedList([1, 2])
            data = rand(Int)
            insertAt!(llist, data, 2)
            llist.head.data == 1 &&
            llist.head.next.data == data &&
            llist.head.next.next.data == 2
        end
        @test_throws BoundsError begin
            llist = LinkedList([1, 2])
            data = rand(Int)
            insertAt!(llist, data, 0)
        end
        @test_throws BoundsError begin
            llist = LinkedList([1, 2])
            data = rand(Int)
            insertAt!(llist, data, 4)
        end
    end

    @testset "Sorted Insertion" begin
        @test begin
            llist = LinkedList([1, 3, 5])
            data = 0
            sortedInsert!(llist, data)
            llist.head.data == data
        end
        @test begin
            llist = LinkedList([1, 3, 5])
            data = 4
            sortedInsert!(llist, data)
            asVector(llist) == [1, 3, 4, 5]
        end
        @test begin
            llist = LinkedList([1, 3, 5])
            data = 6
            sortedInsert!(llist, data)
            asVector(llist) == [1, 3, 5, 6]
        end
    end

    @testset "Deletion" begin
        @test_throws BoundsError begin
            llist = LinkedList([1, 2, 3])
            deleteAt!(llist, 0)
        end
        @test begin
            llist = LinkedList()
            deleteAt!(llist, 1)
            llist.head == nothing
        end
        @test begin
            llist = LinkedList([1, 2, 3])
            deleteAt!(llist, 1)
            asVector(llist) == [2, 3]
        end
        @test begin
            llist = LinkedList([1, 2, 3])
            deleteAt!(llist, 2)
            asVector(llist) == [1, 3]
        end
        @test begin
            llist = LinkedList([1, 2, 3])
            deleteAt!(llist, 3)
            asVector(llist) == [1, 2]
        end
        @test_throws BoundsError begin
            llist = LinkedList([1, 2, 3])
            deleteAt!(llist, 4)
        end
    end

    @testset "Reversal" begin
        @test begin
            llist = LinkedList("cat")
            reverse!(llist)
            asString(llist) == "tac"
        end
        @test begin
            llist = LinkedList()
            reverse!(llist)
            llist.head == nothing
        end
    end

    @testset "Compare" begin
        @test begin
            ll1 = LinkedList()
            ll2 = LinkedList()
            compare(ll1, ll2)
        end
        @test begin
            ll1 = LinkedList()
            ll2 = LinkedList("cat")
            !compare(ll1, ll2)
        end
        @test begin
            ll1 = LinkedList("cat")
            ll2 = LinkedList("cat")
            compare(ll1, ll2)
        end
        @test begin
            ll1 = LinkedList("cat")
            ll2 = LinkedList("cap")
            !compare(ll1, ll2)
        end
    end

    @testset "Merging" begin
        @test begin
            A = LinkedList([1, 2, 4])
            B = LinkedList([0, 3])
            res = merge!(A, B)
            asVector(res) == [0, 1, 2, 3, 4]
        end
        @test begin
            A = LinkedList([1, 2, 4])
            B = LinkedList()
            res = merge!(A, B)
            res == A
        end
        @test_throws ErrorException begin
            A = LinkedList([1, 2, 3])
            B = LinkedList([4, 0])
            res = merge!(A, B)
        end
        @test_throws ErrorException begin
            A = LinkedList([1, 2, 3])
            B = LinkedList([0, 4]; SLL=false)
            res = merge!(A, B)
        end
        @test_throws ErrorException begin
            A = LinkedList([1, 2, 3])
            B = LinkedList("cat")
            res = merge!(A, B)
        end
    end

    @testset "Get From Tail" begin
        @test begin
            llist = LinkedList([1, 2, 3])
            node = getFromTail(llist, 1)
            node.data == 3
        end
        @test begin
            llist = LinkedList([1, 2, 3])
            node = getFromTail(llist, 3)
            node.data == 1
        end
        @test_throws BoundsError begin
            llist = LinkedList([1, 2, 3])
            node = getFromTail(llist, 0)
        end
        @test_throws BoundsError begin
            llist = LinkedList([1, 2, 3])
            node = getFromTail(llist, 4)
        end
    end

    @testset "Get Node" begin
        @test begin
            llist = LinkedList([1, 2, 3])
            node = getNode(llist, 2)
            node.data == 2
        end
        @test_throws BoundsError begin
            llist = LinkedList([1, 2, 3])
            node = getNode(llist, 0)
        end
        @test_throws BoundsError begin
            llist = LinkedList([1, 2, 3])
            node = getNode(llist, 4)
        end
    end

    @testset "Remove Duplicates" begin
        @test begin
            llist = LinkedList([1, 1, 2, 2, 3, 3])
            removeDuplicates!(llist)
            asVector(llist) == [1, 2, 3]
        end
        @test begin
            llist = LinkedList("aaabccd")
            removeDuplicates!(llist)
            asString(llist) == "abcd"
        end
        @test begin
            llist = LinkedList()
            removeDuplicates!(llist)
            llist.head == nothing
        end
    end

    @testset "Find Merge Node" begin
        @test begin
            A = LinkedList([1, 2, 3])
            B = LinkedList([4, 5])
            C = LinkedList([6, 7])
            A.head.next.next.next = C.head
            B.head.next.next = C.head
            findMergeNode(A, B) == C.head
        end
    end

    @testset "Has Cycle?" begin
        @test begin
            llist = LinkedList([1, 2, 3])
            !hasCycle(llist)
        end
        @test begin
            llist = LinkedList([1, 2, 3])
            llist.head.next.next.next = llist.head # create cycle
            hasCycle(llist)
        end
        @test begin
            llist = LinkedList([1, 2, 3])
            llist.head.next.next.next = llist.head.next # create cycle
            hasCycle(llist)
        end
    end

end
