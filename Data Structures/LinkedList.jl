#!/Applications/Julia-1.2.app/Contents/Resources/julia/bin/julia
import Base.show

mutable struct SLLNode{T}
    data::T
    next::Union{SLLNode, Nothing}
end

mutable struct DLLNode{T}
    data::T
    next::Union{DLLNode, Nothing}
    prev::Union{DLLNode, Nothing}
end

mutable struct LinkedList
    head::Union{SLLNode, DLLNode, Nothing}
end

# creates a Singly Linked List from a given array of ordered data
function createSLL(data::Union{Vector, Nothing})
    if data == nothing || length(data) == 0
        return LinkedList(nothing)
    elseif length(data) == 1
        return LinkedList(SLLNode(data[1], nothing))
    else
        last = nothing
        for x = reverse(data)
            last = SLLNode(x, last) # create new element linked backwards
        end
        return LinkedList(last)
    end
end

# creates a Doubly Linked List from a given array of ordered data
function createDLL(data::Union{Vector, Nothing})
    if data == nothing || length(data) == 0
        return LinkedList(nothing)
    elseif length(data) == 1
        return LinkedList(DLLNode(data[1], nothing, nothing))
    else
        last = nothing
        for x = reverse(data)
            last = DLLNode(x, last, nothing)
            if(last != nothing && last.next != nothing)
                last.next.prev = last
            end
        end
        return LinkedList(last)
    end
end

# creates a sorted (ascending) Singly Linked List from a given array of ordered data
function createSortedSLL(data::Union{Vector, Nothing})
    if length(data) == 1
        return LinkedList(SLLNode(data[1], nothing, nothing))
    else
        head = nothing
        for x = data
            head = sortedInsert!(head, x)
        end
        return LinkedList(head)
    end
end

# creates a sorted (ascending) Doubly Linked List from a given array of ordered data
function createSortedDLL(data::Union{Vector, Nothing})
    if length(data) == 1
        return LinkedList(DLLNode(data[1], nothing, nothing))
    else
        head = nothing
        for x = data
            head = sortedInsert!(head, x; SLL=false)
        end
        return LinkedList(head)
    end
end

# show Linked List node's data
function show(io::IO, node::Union{SLLNode, DLLNode})
    show(io, node.data)
end

# show full Linked List
function show(io::IO, llist::LinkedList)
    head = llist.head
    ans = "["
    if head == nothing
        ans = string(ans, "* empty *]")
        println(ans)
        return
    end
    current = head
    ans = string(ans, head.data)
    link = (isa(head, SLLNode) ? "->" : "<->")
    while current.next != nothing
        current = current.next
        ans = string(ans, link, current.data)
    end
    ans = string(ans, "]")
    println(ans)
end

# traverse the Linked List and print the data of the nodes
function printLL(head::Union{SLLNode, DLLNode, Nothing})
    if head == nothing
        println("* empty list *")
        return
    end
    current = head
    print(head.data)
    link = (isa(head, SLLNode) ? "->" : "<->")
    while current.next != nothing
        current = current.next
        print(link, current.data)
    end
    println()
end

# insert to tail of Linked List
function insertAtTail!(head::Union{SLLNode, DLLNode, Nothing}, data; SLL=true)
    if head == nothing
        if SLL
            return SLLNode(data, nothing)
        else
            return DLLNode(data, nothing, nothing)
        end
    else
        SLL = isa(head, Union{SLLNode, Nothing})
        current = head
        while current.next != nothing
            current = current.next
        end
        if(SLL)
            current.next = SLLNode(data, nothing)
        else
            current.next = DLLNode(data, nothing, current)
        end
    end
    return head
end

# insert at head of Linked List
function insertAtHead!(head::Union{SLLNode, DLLNode, Nothing}, data; SLL=true)
    if head != nothing
        SLL = isa(head, Union{SLLNode, Nothing})
    end

    if SLL
        newHead = SLLNode(data, nothing)
    else
        newHead = DLLNode(data, nothing, nothing)
    end

    newHead.next = head

    return newHead
end

# insert at 0-based pos of Linked List
function insertAt!(head::Union{SLLNode, DLLNode, Nothing}, data, pos::Int; SLL=true)
    current = head
    if head != nothing
        SLL = isa(head, Union{SLLNode, Nothing})
    end
    if pos == 0
        if SLL
            current = SLLNode(data, head)
        else
            current = DLLNode(data, head, nothing)
        end
        return current
    else
        while pos > 1
            current = current.next
            pos -= 1
        end
        temp = current.next
        if(SLL)
            current.next = SLLNode(data, temp)
        else
            current.next = DLLNode(data, temp, current)
        end
        return head
    end
end

# ordered insert of element into sorted doubly-linked list, preserving order
function sortedInsert!(head::Union{SLLNode, DLLNode, Nothing}, data; SLL=true)
    if head == nothing
        if(SLL)
            head = SLLNode(data, nothing)
        else
            head = DLLNode(data, nothing, nothing)
        end
        return head
    end

    SLL = isa(head, Union{SLLNode, Nothing})

    # handles case where node is added at front
    if data < head.data
        if(SLL)
            newNode = SLLNode(data, head)
        else
            newNode = DLLNode(data, head, nothing)
            head.prev = newNode
        end
        return newNode
    end

    i = head
    while(i.next != nothing && i.next.data < data)
        i = i.next
    end # advance cursor until at correct position

    next = i.next
    if(SLL)
        newNode = SLLNode(data, next)
    else
        newNode = DLLNode(data, next, i)
    end
    i.next = newNode

    if(!SLL && next != nothing)
        next.prev = newNode
    end

    return head
end

# delete node at 0-based pos of Linked List
function deleteAt!(head::Union{SLLNode, DLLNode, Nothing}, pos::Int)
    if head == nothing
        return nothing
    end
    if pos == 0
        ans = head.next
        head.next = nothing
        if(isa(head, DLLNode))
            head.prev = nothing
        end
        return ans
    end

    current = head
    while pos > 1
        current = current.next
        pos -= 1
    end
    if current.next != nothing
        current.next = current.next.next
        if(isa(head, DLLNode) && current.next != nothing)
            current.next.prev = current
        end
    end
    return head
end

# reverse print a Linked List
function reversePrint(head::Union{SLLNode, DLLNode, Nothing})
    if head == nothing
        return
    end

    reversePrint(head.next)

    if(isa(head, SLLNode))
        print("<-", head.data)
    else
        print(">-<", head.data)
    end
end

# reverse a Linked List
function reverse!(head::Union{SLLNode, DLLNode, Nothing})
    if head == nothing
        return head
    end

    c = head
    n = head.next
    if(isa(head, DLLNode))
        p = head.prev
    end

    head = reverse!(n)

    if(n == nothing)
        head = c
        if(isa(head, SLLNode))
            return head
        end
    end

    if(isa(head, DLLNode))
        c.prev = n
        c.next = p
    else
        n.next = c
        c.next = nothing
    end
    return head
end

# compare if two Linked Lists are equal
function compare(headA::Union{SLLNode, DLLNode, Nothing}, headB::Union{SLLNode, DLLNode, Nothing})
    # return false if heads are not matching
    if (headA == nothing && headB != nothing) || (headA != nothing && headB == nothing)
        return false
    end

    # check every node if equal
    while(headA != nothing && headB != nothing)
        if(headA.data != headB.data)
            return false
        end

        headA = headA.next
        headB = headB.next
    end

    # if either A or B has nodes remaining return false, otherwise, return true
    if (headA != nothing || headB != nothing)
        return false
    else
        return true
    end
end

# merge sorted singly Linked Lists A and B
function merge!(headA::Union{SLLNode, Nothing}, headB::Union{SLLNode, Nothing})
    if (headA == nothing || headB == nothing)
        return (headA != nothing ? headA : headB)
    end

    if (headA.data <= headB.data)
        head = headA
        smaller = headA
        bigger = headB
    else
        head = headB
        smaller = headB
        bigger = headA
    end

    while (bigger != nothing)
        # proceed along smaller branch until an element bigger than the bigger branch
        # is found (or until the end is reached)
        while (smaller.next != nothing && smaller.next.data <= bigger.data)
            # advance the smaller branch
            smaller = smaller.next
        end

        # stack the smaller branch onto bigger branch, reassign smaller/bigger comparisons
        temp = smaller.next
        smaller.next = bigger
        smaller = bigger
        bigger = temp
    end

    # once branches are combined
    return head
end

# merge sorted doubly Linked Lists A and B
function merge!(headA::Union{DLLNode, Nothing}, headB::Union{DLLNode, Nothing})
    if (headA == nothing || headB == nothing)
        return (headA != nothing ? headA : headB)
    end

    if (headA.data <= headB.data)
        head = headA
        smaller = headA
        bigger = headB
    else
        head = headB
        smaller = headB
        bigger = headA
    end

    while (bigger != nothing)
        # proceed along smaller branch until an element bigger than the bigger branch
        # is found (or until the end is reached)
        while (smaller.next != nothing && smaller.next.data <= bigger.data)
            # advance the smaller branch
            smaller = smaller.next
        end

        # stack the smaller branch onto bigger branch, reassign smaller/bigger comparisons
        temp = smaller.next
        smaller.next = bigger
        bigger.prev = smaller # the difference for DLL
        smaller = bigger
        bigger = temp
    end

    # once branches are combined
    return head
end

# get node at 0-based position pst from tail of Linked List
function getFromTail(head::Union{SLLNode, DLLNode, Nothing}, pft::Int)
    ahead = head
    behind = head

    for i = 1:pft
        ahead = ahead.next
    end

    while ahead.next != nothing
        ahead = ahead.next
        behind = behind.next
    end

    return behind
end

# get node at 0-based (valid) position pos from head of Linked List
function getNode(head::Union{SLLNode, DLLNode, Nothing}, pos::Int)
    curr = head

    while(curr.next != nothing && pos > 0)
        curr = curr.next
        pos -= 1
    end

    return curr
end

# delete duplicates from sorted Linked List
function removeDuplicates!(head::Union{SLLNode, DLLNode, Nothing})
    if head == nothing
        return head
    end

    current = head

    while(current != nothing)
        while(current.next != nothing && current.data == current.next.data)
            current.next = current.next.next
            if(isa(head, DLLNode) && current.next != nothing)
                current.next.prev = current
            end
        end

        current = current.next
    end

    return head
end

# find merge node of two Linked Lists, heads guaranteed to merge somewhere and exist.
# Returns node rather than value
function findMergeNode(headA::Union{SLLNode, DLLNode, Nothing}, headB::Union{SLLNode, DLLNode, Nothing})
    c1, c2 = headA, headB

    while(c1 != c2)
        if(c1.next == nothing)
            c1 = headB
        else
            c1 = c1.next
        end

        if(c2.next == nothing)
            c2 = headA
        else
            c2 = c2.next
        end
    end

    return c1
end

# checks whether Linked List has cycles or not
function hasCycle(head::Union{SLLNode, DLLNode, Nothing})
    slow = fast = head

    while(fast != nothing && fast.next != nothing)
        slow = slow.next
        fast = fast.next.next
        if(slow == fast)
            return true
        end
    end

    return false
end

# returns a vector of the data in linked list
function asVector(llist::LinkedList)
    ans = []

    head = llist.head
    while(head != nothing)
        append!(ans, head.data)
        head = head.next
    end

    return ans
end

# sort the LinkedList and return as copy
function sort(llist::LinkedList)
    data = asVector(llist)

    if(isa(llist.head, DLLNode))
        return createSortedDLL(data)
    else
        return createSortedSLL(data)
    end
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    N = parse(Int, readline(stdin))
    A = [parse(Int, readline(stdin)) for i=1:N]

    sll = createSLL(A)
    sdll = sort(sll)

    print("SLL: ")
    show(sll)
    print("Sorted SLL: ")
    show(sdll)

end
