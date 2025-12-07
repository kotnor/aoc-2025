import Algorithms
import Foundation

struct Day06: AdventDay {
    enum Operation: Character {
        case added = "+"
        case multiplied = "*"
    }
    
    struct Command {
        let numbers: [Int]
        let operation: Operation
    }
    
    var data: String
    
    var command1: [Command] {
        let splittedData = data.split(separator: "\n")
        
        let numbers = splittedData.prefix(splittedData.count - 1)
            .map {
                $0.split(separator: " ").compactMap {( Int($0) )}
            }
        
        var transposedNumbers: [[Int]] = Array(
            repeating: Array(repeating: numbers[0][0], count: numbers.count),
            count: numbers[0].count
        )
        
        for i in 0..<numbers.count {
            for j in 0..<numbers[i].count {
                transposedNumbers[j][i] = numbers[i][j]
            }
        }
        
        let operations = Array(splittedData.last!).compactMap { Operation(rawValue: $0) }
        
        return operations.enumerated().map {
            .init(numbers: transposedNumbers[$0.offset], operation: $0.element)
        }
    }
    
    var command2: [Command] {
        let linesWithChars = data.split(separator: "\n").map(Array.init)
        
        var columnsWithChars: [[Character]] = Array(
            repeating: Array(
                repeating: linesWithChars[0][0],
                count: linesWithChars.count - 1
            ),
            count: linesWithChars[0].count
        )
        
        for i in 0..<linesWithChars.count - 1{
            for j in 0..<linesWithChars[i].count {
                columnsWithChars[j][i] = linesWithChars[i][j]
            }
        }
        
        var allNumbers: [[Int]] = []
        var numbers: [Int] = []
        for i in 0..<columnsWithChars.count {
            var number = 0
            for j in 0..<columnsWithChars[i].count {
                if let digit = Int(String(columnsWithChars[i][j])) {
                    number = number * 10 + digit
                }
            }
            
            if number == 0 {
                allNumbers.append(numbers)
                numbers = []
            } else {
                numbers.append(number)
            }
        }
        
        allNumbers.append(numbers)
        
        let operations = linesWithChars.last!.compactMap { Operation(rawValue: $0) }
        
        return operations.enumerated().map {
            .init(
                numbers: allNumbers[$0.offset],
                operation: $0.element
            )
        }
    }
    
    func part1() -> Any {
        command1.reduce(0) { $0 + execute(command: $1) }
    }
    
    func part2() -> Any {
        command2.reduce(0) { $0 + execute(command: $1) }
    }
    
    private func execute(command: Command) -> Int {
        switch command.operation {
        case .added:
            command.numbers.reduce(0, +)
        case .multiplied:
            command.numbers.reduce(1, *)
        }
    }
}
