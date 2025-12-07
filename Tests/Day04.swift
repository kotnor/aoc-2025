import XCTest

@testable import AdventOfCode

final class Day04Tests: XCTestCase {
    let testData = """
    ..@@.@@@@.
    @@@.@.@.@@
    @@@@@.@.@@
    @.@@@@..@.
    @@.@@@@.@@
    .@@@@@@@.@
    .@.@.@.@@@
    @.@@@.@@@@
    .@@@@@@@@.
    @.@.@@@.@.
    """

    func testPart1() throws {
        let challenge = Day04(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "13")
    }

    func testPart2() throws {
        let challenge = Day04(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "43")
    }
}
