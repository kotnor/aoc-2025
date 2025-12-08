import Algorithms
import Foundation

struct Day07: AdventDay {
    enum Cell: Character {
        case start = "S"
        case splitter = "^"
        case empty = "."
        case visited = "|"
    }
    
    var data: String
    
    var map: [[Cell]] {
        data.split(separator: "\n").map {
            $0.compactMap(Cell.init)
        }
    }
    
    func part1() -> Any {
        var startRowIndex = -1
        var startColIndex = -1
        
        let map = map
        
        for i in 0..<map.count {
            for j in 0..<map[i].count {
                if map[i][j] == .start {
                    startRowIndex = i
                    startColIndex = j
                    break
                }
            }
        }
        
        var splittersCount = 0
        var visitedCols: Set<Int> = [startColIndex]
        
        for i in (startRowIndex + 1)..<map.count {
            var newVisitedCols: Set<Int> = []
            var removableVisitedCols: Set<Int> = []
            
            for j in 0..<map[i].count {
                if map[i][j] == .splitter && visitedCols.contains(j) {
                    splittersCount += 1
                    if j > 0 && j < map[i].count {
                        newVisitedCols.insert(j - 1)
                    }
                    
                    if j >= 0 && j < map[i].count - 1 {
                        newVisitedCols.insert(j + 1)
                    }
                    
                    removableVisitedCols.insert(j)
                }
            }
            
            visitedCols.subtract(removableVisitedCols)
            visitedCols.formUnion(newVisitedCols)
        }
        
        return splittersCount
    }
    
    func part2() -> Any {
        var startRowIndex = -1
        var startColIndex = -1
        
        for i in 0..<map.count {
            for j in 0..<map[i].count {
                if map[i][j] == .start {
                    startRowIndex = i
                    startColIndex = j
                    break
                }
            }
        }
        
        struct ValueCache: Hashable {
            let row: Int
            let column: Int
        }
        
        var cache: [ValueCache: Int] = [:]
        func calculate(row: Int, column: Int) -> Int {
            guard row < map.count - 1 else {
                return 1
            }
            
            if let value = cache[.init(row: row, column: column)] {
                return value
            }
            
            var result = 0
            
            if map[row + 1][column] == .splitter {
                if column > 0 {
                    result += calculate(row: row + 1, column: column - 1)
                }
                
                if column < map[row].count - 1 {
                    result += calculate(row: row + 1, column: column + 1)
                }
            } else {
                result += calculate(row: row + 1, column: column)
            }
            
            cache[.init(row: row, column: column)] = result
            
            return result
        }
        
        return calculate(row: startRowIndex, column: startColIndex)
    }
}
