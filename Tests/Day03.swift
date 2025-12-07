import XCTest

@testable import AdventOfCode

final class Day03Tests: XCTestCase {
    let testData = """
    987654321111111
    811111111111119
    234234234234278
    818181911112111
    """

    func testPart1() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "357")
    }

    func testPart2() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "3121910778619")
    }
}
