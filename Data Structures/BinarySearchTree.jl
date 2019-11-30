#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
using DataStructures
import Base.show

mutable struct BSTNode{T}
    data::T
    left::Union{BSTNode{T}, Nothing}
    right::Union{BSTNode{T}, Nothing}
    BSTNode(x::T) where {T} = new{T}(x, nothing, nothing)
    BSTNode(data::T, left::Union{BSTNode{T}, Nothing},
            right::Union{BSTNode{T}, Nothing}) where {T} = new{T}(data, left, right)
end

mutable struct BinarySearchTree
    root::Union{BSTNode, Nothing}
    BinarySearchTree() = new(nothing)
    BinarySearchTree(root::Union{BSTNode, Nothing}) where {T} = new(root)
    BinarySearchTree(data::Union{Vector, String}) = createBST(data)
end

# create Binary Search Tree from array of data
function createBST(data::Union{Vector, String})
    if data == nothing || length(data) == 0
        return BinarySearchTree(nothing)
    elseif length(data) == 1
        return BinarySearchTree(BSTNode(data[1], nothing, nothing))
    else
        root = nothing
        for x = data
            root = insert!(root, x)
        end
        return BinarySearchTree(root)
    end
end

# pre-order traversal of the tree
function preorder(root::Union{BSTNode, Nothing}, f::Function)
    if root == nothing
        return
    end

    f(root.data)
    preorder(root.left, f)
    preorder(root.right, f)
end

# post-order traversal of the tree
function postorder(root::Union{BSTNode, Nothing}, f::Function)
    if root == nothing
        return
    end

    postorder(root.left, f)
    postorder(root.right, f)
    f(root.data)
end

# in-order traversal of the tree
function inorder(root::Union{BSTNode, Nothing}, f::Function)
    if root == nothing
        return
    end

    inorder(root.left, f)
    f(root.data)
    inorder(root.right, f)
end

# return the height of the tree
function height(root::Union{BSTNode, Nothing})
    if root == nothing
        return -1
    end

    l = height(root.left)
    r = height(root.right)
    return 1 + max(l, r)
end

# perform function f on the Top View of the tree
function toporder(root::Union{BSTNode, Nothing}, f::Function)
    if root == nothing
        return
    end

    # map of dist to levels and nodes
    m = Dict()
    q = []

    # add root to the queue
    append!(q, (0, 0, root))

    while(!isempty(q))
        dist = popfirst!(q)
        level = popfirst!(q)
        node = popfirst!(q)

        if(!haskey(m, dist) || level < m[dist][1])
            m[dist] = Pair(level, node)
        end

        if(node.left != nothing)
            append!(q, (dist-1, level+1, node.left))
        end

        if(node.right != nothing)
            append!(q, (dist+1, level+1, node.right))
        end
    end

    # list of the node's data in top view order
    ans = [(m[k][2].data) for k in sort([i for i=keys(m)])]

    for a = ans
        f(a)
    end
end

# level-order traversal of the tree
function levelorder(root::Union{BSTNode, Nothing}, f::Function)
    if root == nothing
        return
    end

    q = []

    # add root to the queue
    append!(q, (root,))

    while(!isempty(q))
        node = popfirst!(q)

        f(node.data)

        if(node.left != nothing)
            append!(q, (node.left,))
        end
        if(node.right != nothing)
            append!(q, (node.right,))
        end
    end
end

# insert node into BST
function insert!(root::Union{BSTNode, Nothing}, val)
    if root == nothing
        return BSTNode(val, nothing, nothing)
    end

    curr = root

    while(true)
        if val < curr.data
            if curr.left != nothing
                curr = curr.left
            else
                curr.left = BSTNode(val, nothing, nothing)
                break
            end
        elseif val > curr.data
            if curr.right != nothing
                curr = curr.right
            else
                curr.right = BSTNode(val, nothing, nothing)
                break
            end
        else
            break
        end
    end

    return root
end

# get the Lowest Common Ancestor (LCA) of the given node values v1, v2
function getLCA(root::Union{BSTNode{T}, Nothing}, v1::T, v2::T) where {T}
    if getNode(root, n->n.data == v1) == nothing || getNode(root, n->n.data == v2) == nothing
        error("Given values not found in node!")
    end
    if v1 == root.data || v2 == root.data
        return root
    end

    if(v1 < root.data)
        if(v2 < root.data)
            return getLCA(root.left, v1, v2)
        else
            return root
        end
    else
        if(v2 > root.data)
            return getLCA(root.right, v1, v2)
        else
            return root
        end
    end
end

# get node from tree that satisfies f(node) = true, returns nothing if not found in tree
function getNode(root::Union{BSTNode, Nothing}, f::Function)
    if root == nothing
        return nothing
    end

    if f(root)
        return root
    else
        l = getNode(root.left, f)
        if (l != nothing)
            return l
        else
            return getNode(root.right, f)
        end
    end
end

mutable struct HuffNode
    data::Char
    freq::Int
    parent::Union{BSTNode{HuffNode}, Nothing}
end

# create a Huffman Tree based on Huffman encoding of the given string s
function createHuffTree(s::String)
    if length(s) == 0
        return nothing
    end

    ω = Dict{Char, Int}() # Map of Character to Frequency
    pq = PriorityQueue{BSTNode, Int}() # Priority Queue of Node to Frequencies

    for c = s
        ω[c] = get!(ω, c, 0) + 1 # increment counter of character by 1
    end # generate freq dict

    for k = collect(keys(ω))
        node = BSTNode(HuffNode(k, ω[k], nothing), nothing, nothing)
        pq[node] = ω[k]
    end # create leaf nodes

    # following Huffman encoding algorithm
    while(length(pq) > 1)
        n1 = dequeue!(pq)
        n2 = dequeue!(pq)

        # create parent node
        node = BSTNode(HuffNode(Char(0), n1.data.freq+n2.data.freq, nothing), n1, n2)
        enqueue!(pq, node, n1.data.freq+n2.data.freq)

        # assign parents
        n1.data.parent = node
        n2.data.parent = node
    end

    # root of Huffman Tree
    root = dequeue!(pq)

    return root
end

# encode a given string s using the given Huffman tree
function encodeHuff(root::Union{BSTNode{HuffNode}, Nothing}, s::String)
    ans = ""

    for c = s
        node = getNode(root, x->x.data.data == c) # get leaf
        if node != nothing
            curr = node
            bit = ""
            while(curr != root)
                if(curr == curr.data.parent.left) # if current node is on left branch
                    bit = string("0", bit)
                else
                    bit = string("1", bit)
                end
                curr = curr.data.parent # move up tree towards root
            end
            ans = string(ans, bit)
        else
            error("Character " * c * " not found in Huffman tree!")
        end
    end

    return ans
end

# return a decoded Huffman-encoded string of 0 and 1 using given Huffman Tree
function decodeHuff(root::Union{BSTNode{HuffNode}, Nothing}, s::String)
    curr = root
    ans = ""

    for c = s
        if(c == '0')
            curr = curr.left # move left
        elseif(c == '1')
            curr = curr.right # move right
        end

        if(curr.left == nothing && curr.right == nothing) # node is leaf
            ans = string(ans, curr.data.data)
            curr = root
        end
    end

    return ans
end

# swap children of the given node
function swapChildren!(node::BSTNode)
    temp = node.left
    node.left = node.right
    node.right = temp
end

# check if given tree is a BST, where lb and ub are the lower and upper bounds
function checkBST(root::Union{BSTNode{T}, Nothing}, lb::T, ub::T) where {T}
    if root == nothing
        return true
    end

    if root.data <= lb
        return false
    end
    if root.data >= ub
        return false
    end

    return checkBST(root.left, lb, root.data) && checkBST(root.right, root.data, ub)
end

function checkBST(tree::BinarySearchTree)
    if isa(tree.root, BSTNode)
        if tree.root == nothing
            return true
        else
            return checkBST(tree.root, typemin(typeof(tree.root.data)), typemax(typeof(tree.root.data)))
        end
    else
        return true
    end
end

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    # do something
end
