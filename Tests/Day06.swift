import XCTest

@testable import AdventOfCode

final class Day06Tests: XCTestCase {
    let testData = """
    123 328  51 64 
     45 64  387 23 
      6 98  215 314
    *   +   *   + 
    """

    func testPart1() throws {
        let challenge = Day06(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "4277556")
    }

    func testPart2() throws {
        let challenge = Day06(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "3263827")
    }
}
