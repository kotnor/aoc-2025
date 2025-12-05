import XCTest

@testable import AdventOfCode

final class Day01Tests: XCTestCase {
    let testData = """
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
    """

    func testPart1() throws {
        let challenge = Day01(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "3")
    }

    func testPart2() throws {
        let challenge = Day01(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "6")
    }
}
