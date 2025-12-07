import Algorithms
import Foundation

struct Day03: AdventDay {
    
    var data: String
    
    var entities: [[Int]] {
        data.split(separator: "\n").map { $0.compactMap { Int(String($0)) } }
    }
    
    func part1() -> Any {
        calculateResult(for: 2)
    }
    
    func part2() -> Any {
        calculateResult(for: 12)
    }
    
    private func maxBank(_ bank: [Int], digits: Int) -> Int {
        var sum = 0
        var bank = bank
        
        for digit in (1...digits).reversed() {
            let prefix = bank.count - digit + 1
            let (value, index) = maxValue(in: Array(bank.prefix(prefix)))
            
            sum += value * (pow(10, digit - 1) as NSDecimalNumber).intValue
            bank = bank.suffix(bank.count - index - 1)
        }
        
        return sum
    }

    private func maxValue(in array: [Int]) -> (value: Int, offset: Int) {
        var maxValue = array[0]
        var offset = 0
        
        for i in 0..<array.count {
            if array[i] > maxValue {
                maxValue = array[i]
                offset = i
            }
        }
        
        return (maxValue, offset)
    }
    
    private func calculateResult(for digits: Int) -> Int {
        var sum = 0
        
        for bank in entities {
            let maxBankValue = maxBank(bank, digits: digits)
            sum += maxBankValue
        }
        
        return sum
    }
}
