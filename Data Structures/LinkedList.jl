#!/Applications/Julia-1.2.app/Contents/Resources/julia/bin/julia

mutable struct SinglyLinkedListNode{T}
    data::T
    next::Union{SinglyLinkedListNode, Nothing}
end

mutable struct SinglyLinkedList{T}
    head::SinglyLinkedListNode
end

# creates a Singly Linked List from a given array of ordered data
function createSLL(data)
    if length(data) == 1
        return SinglyLinkedListNode(data[1], nothing)
    else
        return SinglyLinkedListNode(data[1], createSLL(data[2:end]))
    end
end

# traverse the Linked List and print the data of the nodes
function printSLL(head::SinglyLinkedListNode)
    current = head
    print(head.data)
    while current.next != nothing
        current = current.next
        print("->", current.data)
    end
    println()
end

# insert to tail of Linked List
function insertAtTail!(head::Union{SinglyLinkedListNode, Nothing}, data)
    if head == nothing
        return SinglyLinkedListNode(data, nothing)
    else
        current = head
        while current.next != nothing
            current = current.next
        end
        current.next = SinglyLinkedListNode(data, nothing)
    end
    return head
end

# insert at head of Linked List
function insertAtHead!(head::Union{SinglyLinkedListNode, Nothing}, data)
    newHead = SinglyLinkedListNode(data, nothing)
    if head != nothing
        newHead.next = head
    end
    return newHead
end

# insert at 0-based pos of Linked List
function insertAt!(head::Union{SinglyLinkedListNode, Nothing}, data, pos::Int)
    current = head
    if pos == 0
        current = SinglyLinkedListNode(data, head)
        return current
    else
        while pos > 1
            current = current.next
            pos -= 1
        end
        temp = current.next
        current.next = SinglyLinkedListNode(data, temp)
        return head
    end
end

# delete node at 0-based pos of Linked List
function deleteAt!(head::Union{SinglyLinkedListNode, Nothing}, pos::Int)
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
function reversePrint(head::Union{SinglyLinkedListNode, Nothing})
    if head == nothing
        return
    end

    reversePrint(head.next)

    print("<-", head.data)
end

# reverse a Linked List
function reverse!(head::Union{SinglyLinkedListNode, Nothing})
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

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    N = parse(Int, readline(stdin))
    A = [parse(Int, readline(stdin)) for i=1:N];

    head = createSLL(A);
    printSLL(head);
    head = reverse!(head);
    printSLL(head);
end
