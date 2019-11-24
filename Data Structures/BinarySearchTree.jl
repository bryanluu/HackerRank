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
        root = createBST(data[1]).root
        for x = data[2:end]
            curr = root

            while(true)
                if x < curr.data
                    if curr.left != nothing
                        curr = curr.left
                    else
                        curr.left = BSTNode(x, nothing, nothing)
                        break
                    end
                elseif x > curr.data
                    if curr.right != nothing
                        curr = curr.right
                    else
                        curr.right = BSTNode(x, nothing, nothing)
                        break
                    end
                else
                    break
                end
            end
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
end
