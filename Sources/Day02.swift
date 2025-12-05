import Algorithms

struct Day02: AdventDay {
    
    var data: String
    
    var entities: [ClosedRange<Int>] {
        data.filter { $0.isNumber || $0.isPunctuation }.split(separator: ",").compactMap { (string: String.SubSequence) -> ClosedRange<Int>? in
            let ids = string.split(separator: "-")
            guard let left = Int(String(ids[0])),
                  let right = Int(String(ids[1])) else {
                return nil
            }
            return .init(uncheckedBounds: (left, right))
        }
    }
    
    func part1() -> Any {
        var sum = 0
        
        for entity in entities {
            for i in entity where isNotValidForPart(i, maxSliceCount: 2) {
                sum += i
            }
        }
        
        return sum
    }
    
    func part2() -> Any {
        var sum = 0
        
        for entity in entities {
            for i in entity where isNotValidForPart(i) {
                sum += i
            }
        }
        
        return sum
    }
    
    private func isNotValidForPart(_ value: Int, maxSliceCount: Int? = nil) -> Bool {
        let stringValue = String(value)
        let numbersOfSymbols = stringValue.count
        
        guard numbersOfSymbols > 1 else {
            return false
        }
        
        for sliceCount in 2...(maxSliceCount ?? numbersOfSymbols) {
            guard numbersOfSymbols % sliceCount == 0 else {
                continue
            }
            
            if Set(stringValue.chunks(ofCount: stringValue.count / sliceCount)).count == 1 {
                return true
            }
        }
        
        return false
    }
}
