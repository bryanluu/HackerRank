#!/Applications/Julia-1.2.app/Contents/Resources/julia/bin/julia

mutable struct SLLNode{T}
    data::T
    next::Union{SLLNode, Nothing}
end

mutable struct SLL{T}
    head::SLLNode
end

# creates a Singly Linked List from a given array of ordered data
function createSLL(data)
    if length(data) == 1
        return SLLNode(data[1], nothing)
    else
        return SLLNode(data[1], createSLL(data[2:end]))
    end
end

# traverse the Linked List and print the data of the nodes
function printSLL(head::SLLNode)
    current = head
    print(head.data)
    while current.next != nothing
        current = current.next
        print("->", current.data)
    end
    println()
end

# insert to tail of Linked List
function insertAtTail!(head::Union{SLLNode, Nothing}, data)
    if head == nothing
        return SLLNode(data, nothing)
    else
        current = head
        while current.next != nothing
            current = current.next
        end
        current.next = SLLNode(data, nothing)
    end
    return head
end

# insert at head of Linked List
function insertAtHead!(head::Union{SLLNode, Nothing}, data)
    newHead = SLLNode(data, nothing)
    if head != nothing
        newHead.next = head
    end
    return newHead
end

# insert at 0-based pos of Linked List
function insertAt!(head::Union{SLLNode, Nothing}, data, pos::Int)
    current = head
    if pos == 0
        current = SLLNode(data, head)
        return current
    else
        while pos > 1
            current = current.next
            pos -= 1
        end
        temp = current.next
        current.next = SLLNode(data, temp)
        return head
    end
end

# delete node at 0-based pos of Linked List
function deleteAt!(head::Union{SLLNode, Nothing}, pos::Int)
    if head == nothing
        return nothing
    end
    if pos == 0
        ans = head.next
        head.next = nothing
        return ans
    end

    current = head
    while pos > 1
        current = current.next
        pos -= 1
    end
    if current.next != nothing
        current.next = current.next.next
    end
    return head
end

# reverse print a Linked List
function reversePrint(head::Union{SLLNode, Nothing})
    if head == nothing
        return
    end

    reversePrint(head.next)

    print("<-", head.data)
end

# reverse a Linked List
function reverse!(head::Union{SLLNode, Nothing})
    if head == nothing || head.next == nothing
        return head
    end

    p = head
    q = head.next
    head = reverse!(q)
    q.next = p
    p.next = nothing

    return head
end

# compare if two Linked Lists are equal
function compare(headA::Union{SLLNode, Nothing}, headB::Union{SLLNode, Nothing})
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

# merge sorted Linked Lists A and B
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

# get node at 0-based position pst from tail of Linked List
function getFromTail(head::Union{SLLNode, Nothing}, pst::Int)
    ahead = head
    behind = head

    for i = 1:pst
        ahead = ahead.next
    end

    while ahead.next != nothing
        ahead = ahead.next
        behind = behind.next
    end

    return behind
end

# get node at 0-based (valid) position pos from head of Linked List
function getNode(head::Union{SLLNode, Nothing}, pos::Int)
    curr = head

    while(curr.next != nothing && pos > 0)
        curr = curr.next
        pos -= 1
    end

    return curr
end

# delete duplicates from sorted Linked List
function removeDuplicates!(head::Union{SLLNode, Nothing})
    if head == nothing
        return head
    end

    current = head

    while(current != nothing)
        while(current.next != nothing && current.data == current.next.data)
            current.next = current.next.next
        end

        current = current.next
    end

    return head
end

# find merge node of two Linked Lists, heads guaranteed to merge somewhere and exist.
# Returns node rather than value
function findMergeNode(headA::Union{SLLNode, Nothing}, headB::Union{SLLNode, Nothing})
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

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    N = parse(Int, readline(stdin))
    A = [parse(Int, readline(stdin)) for i=1:N];
    N = parse(Int, readline(stdin))
    B = [parse(Int, readline(stdin)) for i=1:N];
    N = parse(Int, readline(stdin))
    X = [parse(Int, readline(stdin)) for i=1:N];

    headA = createSLL(A);
    headB = createSLL(B);
    headX = createSLL(X);
    getFromTail(headA, 0).next = headX;
    getFromTail(headB, 0).next = headX;

    printSLL(headA);
    printSLL(headB);
    println(findMergeNode(headA, headB).data)
end
