import Algorithms
import Foundation

struct Day08: AdventDay {
    struct Coordinates: Hashable {
        let x: Int
        let y: Int
        let z: Int
    }
    
    var data: String
    
    var coordinatesList: [Coordinates] {
        data.split(separator: "\n").map {
            let list = $0.split(separator: ",").compactMap { Int($0) }
            return .init(x: list[0], y: list[1], z: list[2])
        }
    }
    
    private func distance(first: Coordinates, second: Coordinates) -> Int {
        (first.x - second.x) * (first.x - second.x)
        + (first.y - second.y) * (first.y - second.y)
        + (first.z - second.z) * (first.z - second.z)
    }
    
    func part1() -> Any {
        let coordinatesList = coordinatesList
        var disjointSet = DisjointSet(coordinatesList)
        let isTest = coordinatesList.count <= 20
        
        var cache: [[Coordinates]: Int] = [:]
        
        for i in 0..<coordinatesList.count {
            for j in (i+1)..<coordinatesList.count {
                if i == j { continue }
                cache[[coordinatesList[i], coordinatesList[j]]] = distance(
                    first: coordinatesList[i], second: coordinatesList[j]
                )
            }
        }
        
        let sortedCache = cache.sorted(by: {
            $0.value < $1.value
        })
        
        for element in sortedCache.prefix(isTest ? 10 : 1000) {
            let first = element.key[0]
            let second = element.key[1]
            
            if !disjointSet.connected(first, second) {
                disjointSet.union(first, second)
            }
        }
        
        return disjointSet.getSetSizes().sorted().suffix(3).reduce(1, *)
    }
    
    func part2() -> Any {
        let coordinatesList = coordinatesList
        var disjointSet = DisjointSet(coordinatesList)
        
        var cache: [[Coordinates]: Int] = [:]
        
        for i in 0..<coordinatesList.count {
            for j in (i+1)..<coordinatesList.count {
                if i == j { continue }
                cache[[coordinatesList[i], coordinatesList[j]]] = distance(
                    first: coordinatesList[i], second: coordinatesList[j]
                )
            }
        }
        
        let sortedCache = cache.sorted(by: {
            $0.value < $1.value
        })
        
        var lastValue: Int = Int.max
        for element in sortedCache {
            let first = element.key[0]
            let second = element.key[1]
            
            if !disjointSet.connected(first, second) {
                lastValue = first.x * second.x
                disjointSet.union(first, second)
            }
        }
        
        return lastValue
    }
}

struct DisjointSet<Element: Hashable> {
    var parent: [Element: Element]
    private var rank: [Element: Int]
    private var size: [Element: Int]
    private(set) var count: Int
    
    init(_ elements: [Element]) {
        parent = [:]
        rank = [:]
        count = elements.count
        size = [:]
        
        for element in elements {
            parent[element] = element
            rank[element] = 0
            size[element] = 1
        }
    }
    
    mutating func find(_ x: Element) -> Element? {
        guard var current = parent[x] else { return nil }
        
        // Path compression
        while parent[current] != current {
            parent[current] = parent[parent[current]!]!
            current = parent[current]!
        }
        return current
    }
    
    @discardableResult
    mutating func union(_ x: Element, _ y: Element) -> Bool {
        guard let rootX = find(x), let rootY = find(y) else {
            return false
        }
        
        if rootX == rootY {
            return false
        }
        
        if rank[rootX]! < rank[rootY]! {
            parent[rootX] = rootY
            size[rootY] = (size[rootY] ?? 0) + (size[rootX] ?? 0)
        } else if rank[rootX]! > rank[rootY]! {
            parent[rootY] = rootX
            size[rootX] = (size[rootX] ?? 0) + (size[rootY] ?? 0)
        } else {
            parent[rootY] = rootX
            rank[rootX] = rank[rootX]! + 1
            size[rootX] = (size[rootX] ?? 0) + (size[rootY] ?? 0)
        }
        
        count -= 1
        return true
    }
    
    mutating func connected(_ x: Element, _ y: Element) -> Bool {
        guard let rootX = find(x), let rootY = find(y) else {
            return false
        }
        return rootX == rootY
    }
    
    mutating func sizeOfSet(containing element: Element) -> Int? {
        guard let root = find(element) else { return nil }
        return size[root]
    }
    
    mutating func getAllSets() -> [Set<Element>] {
        var sets: [Element: Set<Element>] = [:]
        
        for element in parent.keys {
            guard let root = find(element) else { continue }
            if sets[root] == nil {
                sets[root] = Set<Element>()
            }
            sets[root]!.insert(element)
        }
        
        return Array(sets.values)
    }
    
    mutating func getSetSizes() -> [Int] {
        getAllSets().map { $0.count }
    }
}
