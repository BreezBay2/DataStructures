//
//  Queue.swift
//  DSA Swift
//
//  Created by Taro Altrichter on 16.11.24.
//

public struct Queue<T> {
    
    var queue: [T] = []
    var isEmpty: Bool { size == 0 }
    var size: Int { queue.count }
    
    public init() {}
    
    mutating func enqueue(_ value: T) {
        queue.append(value)
    }
    
    mutating func dequeue() -> T? {
        return queue.removeFirst()
    }
    
    func peek() -> T? {
        return queue.first
    }
}
