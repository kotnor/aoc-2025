import XCTest

@testable import AdventOfCode

final class Day05Tests: XCTestCase {
    let testData = """
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
    """

    func testPart1() throws {
        let challenge = Day05(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "3")
    }

    func testPart2() throws {
        let challenge = Day05(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "14")
    }
}
