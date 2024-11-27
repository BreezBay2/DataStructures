//
//  LinkedList.swift
//  DSA Swift
//
//  Created by Taro Altrichter on 13.11.24.
//

public class LLNode<T> {
    
    public var value: T
    public var next: LLNode?
    
    public init(value: T, next: LLNode? = nil) {
        self.value = value
        self.next = next
    }
}

public struct LinkedList<T> {
    var head: LLNode<T>?
    var tail: LLNode<T>?
    
    var isEmpty: Bool { size == 0 }
    var size = 0
    
    public var print: String {
        var stringArray = "["
        
        guard var node = head else {
            Swift.print(stringArray + "]")
            return stringArray + "]"
        }
        
        while let next = node.next {
            stringArray += "\(node.value), "
            node = next
        }
        
        stringArray += "\(node.value)"
        Swift.print(stringArray + "]")
        return stringArray + "]"
    }
    
    mutating func clear() {
        var node = head
        while node != nil {
            let next = node?.next
            node = nil
            node = next
        }
        
        head = nil
        tail = nil
        node = nil
        size = 0
        self.print
    }
    
    mutating func push(_ value: T) {
        head = LLNode(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
        
        size += 1
        self.print
    }
    
    mutating func append(_ value: T) {
        if isEmpty {
            push(value)
            return
        }
        
        tail?.next = LLNode(value: value)
        tail = tail?.next
        
        size += 1
        self.print
    }
    
    mutating func insert(_ value: T, at index: Int) {
        
        if index < 0 || index > size { return }
        size += 1
        let newNode = LLNode(value: value)
        
        if index == 0 {
            push(value)
            return
        } else if index == size {
            append(value)
            return
        } else {
            var previousNode = head
            var currentNode = head
            
            for _ in 0 ..< index {
                previousNode = currentNode
                currentNode = currentNode?.next
            }
            
            newNode.next = previousNode?.next
            previousNode?.next = newNode
            
            self.print
        }
    }
    
    func getNode(at index: Int) -> LLNode<T>? {
        if index < 0 || index >= size { return nil }
        
        var i = 0
        var node = head
        
        while i < index {
            node = node?.next
            i += 1
        }
        
        return node
    }
    
    /*
    func indexOf(_ value: T) -> Int {
        var index = 0
        var node = head
        
        for _ in 0 ..< size {
            if value == node?.value {
                return index
            }
            
            node = node?.next
            index += 1
        }
        
        return
    }
    */
    
    func peekFirst() -> T? {
        if isEmpty { return nil }
        return head?.value
    }
    
    func peekLast() -> T? {
        if isEmpty { return nil }
        return tail?.value
    }
    
    mutating func pop() -> LLNode<T>? {
        if isEmpty { return nil }
        
        let node = head
        
        head = head?.next
        if isEmpty {
            tail = nil
        }
        
        size -= 1
        self.print
        return node
    }
    
    mutating func removeLast() -> LLNode<T>? {
        if isEmpty { return nil }
        
        guard head?.next != nil else { return pop() }
        
        var previousNode = head
        var currentNode = head
        
        while let next = currentNode?.next {
            previousNode = currentNode
            currentNode = next
        }
        
        previousNode?.next = nil
        tail = previousNode
        
        size -= 1
        self.print
        return currentNode
    }
    
    mutating func removeAt(at index: Int) -> LLNode<T>? {
        if index < 0 || index >= size { return nil }
        else if index == 0 { return pop() }
        
        var i = 0
        var previousNode = head
        var currentNode = head
        
        while i < index {
            previousNode = currentNode
            currentNode = currentNode?.next
            i += 1
        }
        
        if currentNode?.next == nil {
            return removeLast()
        }
        
        previousNode?.next = currentNode?.next
        
        size -= 1
        self.print
        return currentNode
    }
    
    
}
