import Algorithms

struct Day01: AdventDay {
    enum Command {
        case left(Int)
        case right(Int)
        
        init?(rawValue: Substring) {
            let firstChar = rawValue.first
            
            guard let code = Int(rawValue.dropFirst()) else {
                return nil
            }
            
            if firstChar == "L" {
                self = .left(code)
            } else if firstChar == "R" {
                self = .right(code)
            } else {
                return nil
            }
        }
    }
    
    var data: String
    
    var entities: [Command] {
        data.split(separator: "\n").compactMap { Command(rawValue: $0) }
    }
    
    func part1() -> Any {
        var result = 0
        var currentPosition = 50
        
        for entity in entities {
            switch entity {
            case .left(let value):
                currentPosition = (currentPosition - value) % 100
            case .right(let value):
                currentPosition = (currentPosition + value) % 100
            }
            
            result += currentPosition == 0 ? 1 : 0
        }
        
        return result
    }
    
    func part2() -> Any {
        var result = 0
        var currentPosition = 50
        
        for entity in entities {
            let oldPosition = currentPosition
            
            switch entity {
            case .left(let value):
                result += abs((currentPosition - value) / 100)
                currentPosition = currentPosition - value
            case .right(let value):
                result += abs((currentPosition + value) / 100)
                currentPosition = currentPosition + value
            }
            
            result += (oldPosition * currentPosition <= 0) && (oldPosition != 0)
            ? 1
            : 0
            
            currentPosition %= 100
        }
        
        return result
    }
}
