//
//  AVLTree.swift
//  DataStructures
//
//  Created by Taro Altrichter on 27.11.24.
//

public class AVLTreeNode<T> {
    
    var bf: Int
    var height: Int
    var value: T
    var left: AVLTreeNode?
    var right: AVLTreeNode?

    init(bf: Int, height: Int, value: T, left: AVLTreeNode? = nil, right: AVLTreeNode? = nil) {
        self.bf = bf
        self.height = height
        self.value = value
        self.left = left
        self.right = right
    }
}

extension AVLTreeNode: CustomStringConvertible {
    
    public var description: String {
      diagram(for: self)
    }
    
    private func diagram(for node: AVLTreeNode?, _ top: String = "", _ root: String = "", _ bottom: String = "") -> String {
      
        guard let node = node else {
            return root + "nil\n"
        }
        
        if node.left == nil && node.right == nil {
            return root + "\(node.value)\n"
        }
        
        return diagram(for: node.right, top + " ", top + "┌──", top + "│ ") + root + "\(node.value)\n" + diagram(for: node.left, bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

public struct AVLTree<T: Comparable> {
    
    var nodeCount = 0
    var size: Int { nodeCount }
    
    var root: AVLTreeNode<T>?
    
    private func update(node: AVLTreeNode<T>?) {
        guard let node = node else { return }
        
        let leftNodeHeight = node.left?.height ?? 0
        let rightNodeHeight = node.right?.height ?? 0
        
        node.height = 1 + max(leftNodeHeight, rightNodeHeight)
        
        node.bf = rightNodeHeight - leftNodeHeight
    }
    
    private func balance(node: AVLTreeNode<T>?) -> AVLTreeNode<T>? {
        guard let node = node else { return nil }
        
        if node.bf == -2 {
            if node.left?.bf ?? 0 < 0 {
                return leftLeftCase(node: node)
            } else {
                return leftRightCase(node: node)
            }
        } else if node.bf == +2 {
            if node.right?.bf ?? 0 > 0 {
                return rightRightCase(node: node)
            } else {
                return rightLeftCase(node: node)
            }
        }
        
        return node
    }
    
    private func leftLeftCase(node: AVLTreeNode<T>?) -> AVLTreeNode<T>? {
        return rightRotation(node: node)
    }
    
    private func rightRightCase(node: AVLTreeNode<T>?) -> AVLTreeNode<T>?{
        return leftRotation(node: node)
    }
    
    private func leftRightCase(node: AVLTreeNode<T>?) -> AVLTreeNode<T>? {
        node?.left = leftRotation(node: node?.left)
        return leftLeftCase(node: node)
    }
    
    private func rightLeftCase(node: AVLTreeNode<T>?) -> AVLTreeNode<T>? {
        node?.right = rightRotation(node: node?.right)
        return rightRightCase(node: node)
    }
    
    private func leftRotation(node: AVLTreeNode<T>?) -> AVLTreeNode<T>? {
        let newParent = node?.right
        node?.right = newParent?.left
        newParent?.left = node
        
        update(node: node)
        update(node: newParent)
        
        return newParent
    }
    
    private func rightRotation(node: AVLTreeNode<T>?) -> AVLTreeNode<T>? {
        let newParent = node?.left
        node?.left = newParent?.right
        newParent?.right = node
        
        update(node: node)
        update(node: newParent)
        
        return newParent
    }
    
    func contains(value: T) -> Bool {
        var currentNode = root
        
        while let node = currentNode {
            if node.value == value {
                return true
            }
            
            if value < node.value {
                currentNode = node.left
            } else {
                currentNode = node.right
            }
        }
        
        return false
    }
    
    mutating func insert(_ value: T) -> Bool {
        guard !contains(value: value) else { return false }
        root = insert(node: root, value: value)
        nodeCount += 1
        return true
    }
    
    private func insert(node: AVLTreeNode<T>?, value: T) -> AVLTreeNode<T>? {
        guard let node = node else { return AVLTreeNode(bf: 0, height: 0, value: value)}
        
        if value < node.value {
            node.left = insert(node: node.left, value: value)
        } else {
            node.right = insert(node: node.right, value: value)
        }
        
        update(node: node)
        
        return balance(node: node)
    }
    
    func findMin(node: AVLTreeNode<T>) -> AVLTreeNode<T> {
        var node = node
        
        while let next = node.left {
            node = next
        }
        
        return node
    }
    
    func findMax(node: AVLTreeNode<T>) -> AVLTreeNode<T> {
        var node = node
        
        while let next = node.right {
            node = next
        }
        
        return node
    }
    
    mutating func remove(value: T) -> Bool {
        if contains(value: value) {
            root = remove(node: root, value: value)
            nodeCount -= 1
            return true
        }
        
        return false
    }
    
    private func remove(node: AVLTreeNode<T>?, value: T) -> AVLTreeNode<T>? {
        guard let node = node else { return nil }
        
        if value < node.value {
            node.left = remove(node: node.left, value: value)
        } else if value > node.value {
            node.right = remove(node: node.right, value: value)
        } else {
            if node.left == nil {
                return node.right
            } else if node.right == nil {
                return node.left
            } else if node.left == nil && node.right == nil {
                return nil
            }
            
            node.value = findMin(node: node.right!).value
            node.right = remove(node: node.right, value: node.value)
        }
        
        update(node: node)
        
        return balance(node: node)
    }
}
