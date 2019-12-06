#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
include("LinkedList.jl")

mutable struct Queue{T}
    front::Union{SLLNode{T}, Nothing}
    rear::Union{SLLNode{T}, Nothing}
    Queue{T}() where {T} = new{T}(nothing, nothing)
end

function enqueue!(q::Queue{T}, data::T) where {T}
    if(q.rear == nothing)
        q.rear = SLLNode(data)
        q.front = q.rear
    else
        q.rear.next = SLLNode(data)
        q.rear = q.rear.next
    end
end

function dequeue!(q::Queue{T})::T where {T}
    if isempty(q)
        error("Queue is empty! Nothing to dequeue.")
    end

    ans = q.front
    q.front = q.front.next

    if q.front == nothing
        q.rear = nothing
    end

    ans.next = nothing
    return ans.data
end

function front(q::Queue{T})::T where {T}
    if isempty(q)
        error("Queue is empty! Nothing to dequeue.")
    end

    return q.front.data
end

function isempty(q::Queue{T})::Bool where {T}
    return q.front == nothing && q.rear == nothing
end
