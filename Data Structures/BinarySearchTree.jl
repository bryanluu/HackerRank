#!/Applications/Julia-1.2.app/Contents/Resources/julia/bin/julia
import Base.show

mutable struct BSTNode{T}
    data::T
    left::Union{BSTNode, Nothing}
    right::Union{BSTNode, Nothing}
end

mutable struct BinarySearchTree{T}
    root::Union{BSTNode{T}, Nothing}
end

# create Binary Search Tree from array of data
function createBST(data)
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

# pre-order traversal print of the tree
function preorderPrint(root::Union{BSTNode, Nothing})
    if root == nothing
        return
    end

    print(root.data, " ")
    preorderPrint(root.left)
    preorderPrint(root.right)
end

# post-order traversal print of the tree
function postorderPrint(root::Union{BSTNode, Nothing})
    if root == nothing
        return
    end

    postorderPrint(root.left)
    postorderPrint(root.right)
    print(root.data, " ")
end

# in-order traversal print of the tree
function inorderPrint(root::Union{BSTNode, Nothing})
    if root == nothing
        return
    end

    inorderPrint(root.left)
    print(root.data, " ")
    inorderPrint(root.right)
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

# print the Top View of the tree
function printTopView(root::Union{BSTNode, Nothing})
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

    println(join(ans, " "))
end

# level-order traversal print of the tree
function levelorderPrint(root::Union{BSTNode, Nothing})
    if root == nothing
        return
    end

    q = []

    # add root to the queue
    append!(q, (root,))

    while(!isempty(q))
        node = popfirst!(q)

        print(node.data, " ")

        if(node.left != nothing)
            append!(q, (node.left,))
        end
        if(node.right != nothing)
            append!(q, (node.right,))
        end
    end
end

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

# Main Function
if abspath(PROGRAM_FILE) == @__FILE__
    N = parse(Int, readline(stdin))
    A = parse.(Int, split(readline(stdin)));

    tree = createBST(A)

    print("Pre-order: ")
    preorderPrint(tree.root)
    println()
    print("Post-order: ")
    postorderPrint(tree.root)
    println()
    print("In-order: ")
    inorderPrint(tree.root)
    println()
    print("Height: ")
    println(height(tree.root))
    print("Top-view: ")
    printTopView(tree.root)
    print("Level-order: ")
    levelorderPrint(tree.root)
end
