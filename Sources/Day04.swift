import Algorithms
import Foundation

struct Day04: AdventDay {
    var data: String
    
    var entities: [[Character]] {
        data.split(separator: "\n").map { Array($0) }
    }
    
    func part1() -> Any {
        availablePapers(in: entities).count
    }
    
    func part2() -> Any {
        var cells = self.entities
        
        var sum = 0
        
        while true {
            let availablePapers = self.availablePapers(in: cells)
            
            if availablePapers.isEmpty {
                return sum
            } else {
                sum += availablePapers.count
                
                for availablePaper in availablePapers {
                    cells[availablePaper[0]][availablePaper[1]] = "."
                }
            }
        }
    }
    
    private func availablePapers(in cells: [[Character]]) -> [[Int]] {
        var papers: [[Int]] = []
        
        for row in cells.indices {
            for col in cells[row].indices where cells[row][col] == "@" && isPaperSatisfied(in: cells, cell: (row, col)) {
                papers.append([row, col])
            }
        }
        
        return papers
    }
    
    private func isPaperSatisfied(in cells: [[Character]], cell: (row: Int, col: Int)) -> Bool {
        var neighborsCount = 0
        
        for i in -1...1 {
            for j in -1...1 {
                guard let neighbor = cells[safe: cell.row + i]?[safe: cell.col + j],
                      neighbor == "@",
                      !(i == 0 && j == 0)
                else { continue }
                
                neighborsCount += 1
                
                if neighborsCount >= 4 {
                    return false
                }
            }
        }
        
        return true
    }
}

private extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
