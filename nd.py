from aocd import get_data
import datetime
import os.path

today = datetime.datetime.today()
day_number = f'{today.day:02d}'
year = today.year
input_path = f'./Sources/Data/Day{day_number}.txt'

if not os.path.isfile(input_path):
    with open(input_path, 'w+') as file:
        file.writelines(get_data(day=today.day, year=year))
        file.close()
else:
    print('Input file already exists')

source_path = f'./Sources/Day{day_number}.swift'
if not os.path.isfile(source_path):
    with open(source_path, 'w+') as file:
        source_code = f'''import Algorithms
import Collections

struct Day{day_number}: AdventDay {{
    var data: String
    
    var entities: [[Int]] {{
        data.split(separator: "\\n\\n").map {{
            $0.split(separator: "\\n").compactMap {{ Int($0) }}
        }}
    }}
    
    func part1() -> Any {{
        0
    }}
    
    func part2() -> Any {{
        0
    }}
}}
'''
        file.write(source_code)
        file.close()
else:
    print('Source file already exists')

test_source_path = f'./Tests/Day{day_number}.swift'
if not os.path.isfile(test_source_path):
    with open(test_source_path, 'w+') as file:
        test_source_code = f'''import XCTest
@testable import AdventOfCode

final class Day{day_number}Tests: XCTestCase {{
    let testData = """
    000000000
    """

    func testPart1() throws {{
        let challenge = Day{day_number}(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "0")
    }}

    func testPart2() throws {{
        let challenge = Day{day_number}(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "0")
    }}
}}
'''
        file.write(test_source_code)
        file.close()
else:
    print('Test file already exists')

path_AdventOfCode = './Sources/AdventOfCode.swift'
with open(path_AdventOfCode, 'r') as file:
    data_AdventOfCode = file.readlines()
    file.close()

day_object = f'Day{day_number}()'
if day_object not in ''.join(data_AdventOfCode):
    with open(path_AdventOfCode, 'w') as file:
        data_AdventOfCode.insert(4, f'\t{day_object},\n')
        file.writelines(data_AdventOfCode)
        file.close()
else:
    print(f'The line of code "{day_object}" is already written in the file AdventOfCode.swift ')
