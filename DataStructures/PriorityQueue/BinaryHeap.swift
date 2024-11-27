//
//  BinaryHeap.swift
//  DSA Swift
//
//  Created by Taro Altrichter on 18.11.24.
//

struct BinaryHeap<T: Comparable> {
    var bubbles: [T] = []
    var isMaxHeap = true
    
    init(isMaxHeap: Bool = true) {
        self.isMaxHeap = isMaxHeap
    }
    
    mutating func insert(_ value: T) {
        bubbles.append(value)
        bubbleUp(bubbles.count - 1)
    }
    
    mutating func poll() -> T? {
        removeAt(0)
    }
    
    mutating func remove(_ value: T) -> Bool {
        guard contains(value) else { return false }
        
        for i in 0 ..< bubbles.count {
            if bubbles[i] == value {
                removeAt(i)
                return true
            }
        }
        return false
    }
    
    mutating func removeAt(_ index: Int) -> T? {
        guard !bubbles.isEmpty else { return nil }
        guard index < bubbles.count else { return nil }
        guard bubbles.count > 1 else {
            return bubbles.removeLast()
        }
        
        bubbles.swapAt(index, bubbles.count - 1)
        let value = bubbles.removeLast()
        let swappedValue = bubbles[index]
        
        bubbleDown(index)
        
        if swappedValue == bubbles[index] {
            bubbleUp(index)
        }
        
        return value
    }
    
    func contains(_ value: T) -> Bool {
        if bubbles.contains(value) { return true }
        return false
    }
    
    func peek() -> T? {
        return bubbles.first
    }
    
    mutating func bubbleUp(_ index: Int) {
        var i = index
        let value = bubbles[i]
        
        while i > 0 {
            let parent = (i - 1) / 2
            
            if isMaxHeap && value > bubbles[parent] || !isMaxHeap && value < bubbles[parent] {
                bubbles[i] = bubbles[parent]
                i = parent
            } else {
                break
            }
        }
        
        bubbles[i] = value
    }
    
    mutating func bubbleDown(_ index: Int) {
        var i = index
        let value = bubbles[i]
        
        while 2 * i + 1 < bubbles.count {
            var child = 2 * i + 1
            if child + 1 < bubbles.count && ((isMaxHeap && bubbles[child + 1] > bubbles[child]) || !isMaxHeap && bubbles[child + 1] < bubbles[child]) {
                child += 1
            }
            
            if isMaxHeap && value < bubbles[child] || !isMaxHeap && value > bubbles[child] {
                bubbles[i] = bubbles[child]
                i = child
            } else {
                break
            }
        }
        
        bubbles[i] = value
    }
}
