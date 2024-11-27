//
//  DoublyLinkedList.swift
//  DSA Swift
//
//  Created by Taro Altrichter on 15.11.24.
//

public class DLLNode<T> {
    
    public var value: T
    public var prev: DLLNode?
    public var next: DLLNode?
    
    public init(value: T, prev: DLLNode? = nil, next: DLLNode? = nil) {
        self.value = value
        self.prev = prev
        self.next = next
    }
}

public struct DoublyLinkedList<T> {
    var head: DLLNode<T>?
    var tail: DLLNode<T>?
    
    var isEmpty: Bool { size == 0}
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
        if isEmpty {
            head = DLLNode(value: value)
            tail = head
        } else {
            head?.prev = DLLNode(value: value, next: head)
            head = head?.prev
        }
        
        size += 1
        self.print
    }
    
    mutating func append(_ value: T) {
        if isEmpty {
            head = DLLNode(value: value)
            tail = head
        } else {
            tail?.next = DLLNode(value: value, prev: tail)
            tail = tail?.next
        }
        
        size += 1
        self.print
    }
    
    mutating func insert(_ value: T, at index: Int) {
        
    }
    
    mutating func pop() -> DLLNode<T>? {
        if isEmpty { return nil }
        
        let node = head
        
        head = head?.next
        if isEmpty {
            tail = nil
        }
        
        head?.prev = nil
        
        size -= 1
        self.print
        return node
    }
    
    mutating func removeLast() -> DLLNode<T>? {
        if isEmpty { return nil }
        
        let node = tail
        
        guard head?.next != nil else { return pop() }
        
        tail = tail?.prev
        if isEmpty {
            head = nil
        }
        
        tail?.next = nil
        size -= 1
        self.print
        return node
    }
    
    mutating func removeNode(node: DLLNode<T>?) -> DLLNode<T>? {
        if node?.prev == nil { return pop() }
        if node?.next == nil { return removeLast() }
        
        node?.next?.prev = node?.prev
        node?.prev?.next = node?.next
        
        size -= 1
        self.print
        return node
    }
    
    mutating func removeAt(at index: Int) -> DLLNode<T>? {
        if index < 0 || index >= size { return nil }
        
        var node: DLLNode<T>?
        
        if index < size / 2 {
            var i = 0
            node = head
            while i != index {
                node = node?.next
                i += 1
            }
        } else {
            var i = size - 1
            node = tail
            while i != index {
                node = node?.prev
                i -= 1
            }
        }
        
        return removeNode(node: node)
    }
}
