#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
import Base.isempty

mutable struct Heap{T}
    data::Vector{T}
    comp::Function
    Heap{T}() where {T} = new{T}([], (a,b)->a < b)
    Heap{T}(f::Function) where {T} = new{T}([], f)
    Heap{T}(data::Vector{T}) where {T} = new{T}(data, (a,b)->a < b)
    Heap{T}(data::Vector{T}, f::Function) where {T} = new{T}(data, f)
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

        par = (i)->floor(Int, i/2)
        left = (i)->2i
        right = (i)->2i+1
        n = (h)->length(h.data)

        # compare new root with children, stop if correct order
        while(n(h) > 1 && !(h.comp(first(h.data), h.data[left(1)]) &&
            h.comp(first(h.data), h.data[right(2)])))
            l = left(1)
            r = right(1)
            swap = h.comp(h.data[l], h.data[r]) ? l : r
            h.data[1], h.data[swap] = h.data[swap], h.data[1]; # swap root with smaller/larger child
        end
    elseif(length(h.data) == 1)
        ans = pop!(h.data)
    else
        error("Empty Heap! Nothing to extract.")
    end

    return ans
end

function root(h::Heap{T})::T where {T}
    if(isempty(h))
        error("Empty Heap! Nothing to see")
    end
    return first(h.data)
end

function isempty(h::Heap{T})::Bool where {T}
    return isempty(h.data)
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    # do something
end
