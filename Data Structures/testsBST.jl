#!/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
using Test
include("BinarySearchTree.jl")

@testset "Binary Search Tree Tests" begin
    @testset "Constructor" begin
        @test begin
            tree = BinarySearchTree()
            tree.root == nothing
        end
        @test begin
            data = rand(Int)
            tree = BinarySearchTree([data])
            tree.root.data == data
        end
        @test begin
            data = [1, 2, 3]
            tree = BinarySearchTree(data)
            tree.root.data == 1 &&
            tree.root.right.data == 2 &&
            tree.root.right.right.data == 3
        end
        @test begin
            data = "cat"
            tree = BinarySearchTree(data)
            tree.root.data == 'c' &&
            tree.root.left.data == 'a' &&
            tree.root.right.data == 't'
        end
    end

    @testset "Pre-order" begin
        @test begin
            ans = ""
            func = x->ans *= string(x, " ")
            tree = BinarySearchTree()
            preorder(tree.root, func)
            ans == ""
        end
        @test begin
            ans = ""
            func = x->ans *= string(x, " ")
            data = [1, 2, 5, 3, 6, 4]
            tree = BinarySearchTree(data)
            preorder(tree.root, func)
            ans == "1 2 5 3 4 6 "
        end
    end

    @testset "Post-order" begin
        @test begin
            ans = ""
            func = x->ans *= string(x, " ")
            tree = BinarySearchTree()
            postorder(tree.root, func)
            ans == ""
        end
        @test begin
            ans = ""
            func = x->ans *= string(x, " ")
            data = [1, 2, 5, 3, 6, 4]
            tree = BinarySearchTree(data)
            postorder(tree.root, func)
            ans == "4 3 6 5 2 1 "
        end
    end

    @testset "In-order" begin
        @test begin
            ans = ""
            func = x->ans *= string(x, " ")
            tree = BinarySearchTree()
            inorder(tree.root, func)
            ans == ""
        end
        @test begin
            ans = ""
            func = x->ans *= string(x, " ")
            data = [1, 2, 5, 3, 6, 4]
            tree = BinarySearchTree(data)
            inorder(tree.root, func)
            ans == "1 2 3 4 5 6 "
        end
    end

    @testset "Height" begin
        @test begin
            tree = BinarySearchTree()
            height(tree.root) == -1
        end
        @test begin
            tree = BinarySearchTree([1])
            height(tree.root) == 0
        end
        @test begin
            data = [1, 2, 5, 3, 6, 4]
            tree = BinarySearchTree(data)
            height(tree.root) == 4
        end
    end

    @testset "Top-order" begin
        @test begin
            ans = ""
            func = x->ans *= string(x, " ")
            tree = BinarySearchTree()
            toporder(tree.root, func)
            ans == ""
        end
        @test begin
            ans = ""
            func = x->ans *= string(x, " ")
            data = [1, 2, 5, 3, 6, 4]
            tree = BinarySearchTree(data)
            toporder(tree.root, func)
            ans == "1 2 5 6 "
        end
    end

    @testset "Level-order" begin
        @test begin
            ans = ""
            func = x->ans *= string(x, " ")
            tree = BinarySearchTree()
            levelorder(tree.root, func)
            ans == ""
        end
        @test begin
            ans = ""
            func = x->ans *= string(x, " ")
            data = [1, 2, 5, 3, 6, 4]
            tree = BinarySearchTree(data)
            levelorder(tree.root, func)
            ans == "1 2 5 3 6 4 "
        end
    end

    @testset "LCA" begin
        @test begin
            data = [4, 2, 3, 1, 7, 6]
            tree = BinarySearchTree(data)
            node = getLCA(tree.root, 1, 7)
            node == tree.root
        end
        @test_throws ErrorException begin
            data = [4, 2, 3, 1, 7, 6]
            tree = BinarySearchTree(data)
            node = getLCA(tree.root, 0, 7)
            node == tree.root
        end
    end

    @testset "Get Node" begin
        @test begin
            func = n->n.data == 2
            data = [4, 2, 3, 1, 7, 6]
            tree = BinarySearchTree(data)
            node = getNode(tree.root, func)
            node == tree.root.left
        end
        @test begin
            func = n->n.data == 0
            data = [4, 2, 3, 1, 7, 6]
            tree = BinarySearchTree(data)
            node = getNode(tree.root, func)
            node == nothing
        end
    end

    @testset "Huffman Creation" begin
        @test begin
            s = ""
            root = createHuffTree(s)
            root == nothing
        end
        @test begin
            s = "abracadabra"
            root = createHuffTree(s)

            # pf = x->print(x.data == '\0' ? "0" : x.data)
            # levelorder(root, pf)
            root.left.data.data == 'a' &&
            root.right.left.data.data == 'b' &&
            root.right.right.left.data.data == 'r' &&
            root.right.right.right.left.data.data == 'c' &&
            root.right.right.right.right.data.data == 'd'
        end
    end

    @testset "Huffman Encoding" begin
        @test_throws ErrorException begin
            s = "abracadabra"
            root = createHuffTree(s)
            ans = encodeHuff(root, "p")
        end
        @test begin
            s = "abracadabra"
            root = createHuffTree(s)
            ans = encodeHuff(root, s)
            ans == "01011001110011110101100"
        end
    end

    @testset "Huffman Decoding" begin
        @test begin
            s = "abracadabra"
            code = "01011001110011110101100"
            root = createHuffTree(s)
            ans = decodeHuff(root, code)
            ans == s
        end
    end

    @testset "Swap Children" begin
        @test begin
            data = [2, 1, 3]
            tree = BinarySearchTree(data)
            swapChildren!(tree.root)
            tree.root.left.data == 3 &&
            tree.root.right.data == 1
        end
    end

    @testset "Check BST" begin
        @test begin
            data = [2, 1, 3]
            tree = BinarySearchTree(data)
            checkBST(tree)
        end
        @test begin
            data = [2, 1, 3]
            tree = BinarySearchTree(data)
            swapChildren!(tree.root)
            !checkBST(tree)
        end
    end

    @testset "Create from LO" begin
        @test begin
            data = [1, 2, 3, 4, 5, 6, 7]
            root = createFromLevelOrder(data)
            ans = []
            func = x->append!(ans, x)
            levelorder(root, func)
            ans == data
        end
    end
end
