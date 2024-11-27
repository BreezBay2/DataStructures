//
//  BinarySearchTree.swift
//  DSA Swift
//
//  Created by Taro Altrichter on 17.11.24.
//

public class TreeNode<T> {
    
    var value: T
    var left: TreeNode?
    var right: TreeNode?
    
    init(value: T, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

extension TreeNode: CustomStringConvertible {

  public var description: String {
    diagram(for: self)
  }
  
  private func diagram(for node: TreeNode?, _ top: String = "", _ root: String = "", _ bottom: String = "") -> String {
    
      guard let node = node else {
          return root + "nil\n"
      }
      
      if node.left == nil && node.right == nil {
          return root + "\(node.value)\n"
      }
      
      return diagram(for: node.right, top + " ", top + "┌──", top + "│ ") + root + "\(node.value)\n" + diagram(for: node.left, bottom + "│ ", bottom + "└──", bottom + " ")
  }
}


public struct BinarySearchTree<T: Comparable> {
    
    var nodeCount = 0
    var size: Int { nodeCount }
    
    var root: TreeNode<T>?
    
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
    
    private func insert(node: TreeNode<T>?, value: T) -> TreeNode<T> {
        
        guard let node = node else { return TreeNode(value: value) }
        
        if value < node.value {
            node.left = insert(node: node.left, value: value)
        } else {
            node.right = insert(node: node.right, value: value)
        }
        
        return node
    }
    
    func findMin(node: TreeNode<T>) -> TreeNode<T> {
        var node = node
        
        while let next = node.left {
            node = next
        }
        
        return node
    }
    
    func findMax(node: TreeNode<T>) -> TreeNode<T> {
        var node = node
        
        while let next = node.right {
            node = next
        }
        
        return node
    }
    
    mutating func remove(_ value: T) -> Bool {
        if contains(value: value) {
            root = remove(node: root, value: value)
            nodeCount -= 1
            return true
        }
        
        return false
    }
    
    private func remove(node: TreeNode<T>?, value: T) -> TreeNode<T>? {
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
        
        return node
    }
    
    func preOrderTraversal(node: TreeNode<T>?) {
        guard let node = node else { return }
        print(node.value)
        preOrderTraversal(node: node.left)
        preOrderTraversal(node: node.right)
    }
    
    func inOrderTraversal(node: TreeNode<T>?) {
        guard let node = node else { return }
        inOrderTraversal(node: node.left)
        print(node.value)
        inOrderTraversal(node: node.right)
    }
    
    func postOrderTraversal(node: TreeNode<T>?) {
        guard let node = node else { return }
        postOrderTraversal(node: node.left)
        postOrderTraversal(node: node.right)
        print(node.value)
    }
}
