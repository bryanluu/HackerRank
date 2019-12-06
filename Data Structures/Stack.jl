#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
include("LinkedList.jl")

mutable struct Stack{T}
    top::Union{SLLNode{T}, Nothing}
    Stack{T}() where {T} = new{T}(nothing)
end

function push!(s::Stack{T}, data::T) where {T}
    newHead = SLLNode(data, s.top)
    s.top = newHead
end

function pop!(s::Stack{T})::T where {T}
    if isempty(s)
        error("Stack is empty! Nothing to pop.")
    end
    ans = s.top
    s.top = s.top.next
    ans.next = nothing
    return ans.data
end

function top(s::Stack{T})::T where {T}
    if isempty(s)
        error("Stack is empty! Nothing on top.")
    end
    return s.top.data
end

function isempty(s::Stack{T})::Bool where {T}
    return s.top == nothing
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    # do stuff
end
