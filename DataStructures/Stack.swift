//
//  Stack.swift
//  DSA Swift
//
//  Created by Taro Altrichter on 16.11.24.
//

public struct Stack<T> {
    
    var stack: [T] = []
    var isEmpty: Bool { size == 0 }
    var size: Int { stack.count }
    
    public init() { }
    
    mutating func push(_ value: T) {
        stack.append(value)
    }
    
    mutating func pop() -> T? {
        stack.popLast()
    }
    
    func peek() -> T? {
        stack.last
    }
}
