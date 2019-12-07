#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
import Base.isempty

mutable struct Heap{T}
    data::Vector{T}
    comp::Function
    Heap{T}() where {T} = new{T}([], (a,b)->a < b)
    Heap{T}(f::Function) where {T} = new{T}([], f)
    Heap{T}(data::Vector{T}) where {T} = _makeHeap(data, (a,b)->a < b)
    Heap{T}(data::Vector{T}, f::Function) where {T} = _makeHeap(data, f)
end

function insert!(h::Heap{T}, data::T) where {T}
    push!(h.data, data)

    par = (i)->floor(Int, i/2)
    left = (i)->2i
    right = (i)->2i+1
    n = (h)->length(h.data)

    i = n(h)
    # compare with parent
    while(i != 1 && !h.comp(h.data[par(i)], h.data[i]))
        # swap parent and child if comp is not true
        h.data[i], h.data[par(i)] = h.data[par(i)], h.data[i];
        i = par(i)
    end
end

function extract!(h::Heap{T})::T where {T}
    if(length(h.data) > 1)
        ans = first(h.data)
        h.data[1] = pop!(h.data)

        _maxHeapify(h, 1)
    elseif(length(h.data) == 1)
        ans = pop!(h.data)
    else
        error("Empty Heap! Nothing to extract.")
    end

    return ans
end

function front(h::Heap{T})::T where {T}
    if(isempty(h))
        error("Empty Heap! Nothing to see")
    end
    return first(h.data)
end

function isempty(h::Heap{T})::Bool where {T}
    return isempty(h.data)
end

function _maxHeapify(h::Heap{T}, i::Int) where {T}
    left = 2i
    right = 2i + 1
    choice = i

    if left <= length(h.data) && h.comp(h.data[left], h.data[choice])
        choice = left
    end

    if right <= length(h.data) && h.comp(h.data[right], h.data[choice])
        choice = right
    end

    if choice != i
        h.data[i], h.data[choice] = h.data[choice], h.data[i] # swap with smallest/largest child
        _maxHeapify(h, choice)
    end
end

function _makeHeap(A::Vector{T}, f::Function) where {T}
    h = Heap{T}(f)
    h.data = A
    for i=floor(Int, length(h.data)/2):-1:1
        _maxHeapify(h, i)
    end
    return h
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    # do something
end
