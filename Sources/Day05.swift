import Algorithms
import Foundation

struct Day05: AdventDay {
    struct Ingredients {
        let ranges: [ClosedRange<Int>]
        let ids: [Int]
    }
    
    var data: String
    
    var entities: Ingredients {
        let splittedData = data.split(separator: "\n\n")
        
        return .init(
            ranges: splittedData[0].split(separator: "\n").compactMap {
                let range = $0.split(separator: "-")
                guard let lowerBound = Int(range[0]), let upperBound = Int(range[1]) else {
                    return nil
                }
                
                return ClosedRange(uncheckedBounds: (lowerBound, upperBound))
            },
            ids: splittedData[1].split(separator: "\n").compactMap { Int($0) }
        )
    }
    
    func part1() -> Any {
        let ingredients = self.entities
        
        return ingredients.ids.filter { id in
            ingredients.ranges.contains { $0.contains(id) }
        }.count
    }
    
    func part2() -> Any {
        let ingredients = self.entities
        let normalizedRanges: [ClosedRange<Int>] = normalizeRanges(ingredients.ranges)
        
        return normalizedRanges.reduce(into: 0) { result, range in
            result += range.count
        }
    }
    
    private func normalizeRanges(_ ranges: [ClosedRange<Int>]) -> [ClosedRange<Int>] {
        var normalizedRanges: [ClosedRange<Int>] = []
        
        for range in ranges {
            if let index = normalizedRanges.firstIndex(where: { $0.overlaps(range) }) {
                normalizedRanges[index] = min(normalizedRanges[index].lowerBound, range.lowerBound)...max(normalizedRanges[index].upperBound, range.upperBound)
            } else {
                normalizedRanges.append(range)
            }
        }
        
        if normalizedRanges.count != ranges.count {
            return normalizeRanges(normalizedRanges)
        } else {
            return normalizedRanges
        }
    }
}
