//
//  Day3.swift
//  Advent of Code
//
//  Created by Breno Valadão on 12/12/23.
//

import Foundation

enum Day3 {
    static let sampleChallenge = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

    static func executeChallenge(sample: String = Self.sampleChallenge) {
        let nonSymbols = "0123456789."
        let numbers = "0123456789"

        let matrix = sample
            .splitBreakLines()
            .map { line -> [String] in
                line
                    .split(separator: "")
                    .map { String($0) }
            }
        // find symbols indexes
        let symbolsIndexes = matrix
            .enumerated()
            .flatMap { rowI, row in
                row
                    .enumerated()
                    .filter { !nonSymbols.contains($1) }
                    .map { (rowI, $0.offset) }
            }

        // adjacent indexes
        let numberIndexes = Set(symbolsIndexes
            .flatMap { (x, y) -> [Tuple] in
                let filtered = [
                    (x-1, y-1), (x-1, y), (x-1, y+1),
                    (x, y-1), (x, y+1),
                    (x+1, y-1), (x+1, y), (x+1, y+1)
                ]
                    .filter {
                        ($0.0 >= 0 && $0.1 >= 0) &&
                        ($0.0 < matrix.count && $0.1 < matrix[0].count)
                    }

                let items = filtered
                    .compactMap { (x, y) -> Tuple? in
                        guard matrix[x][y].contains(where: { numbers.contains($0) }) else {
                            return nil
                        }
                        return Tuple(x, y)
                    }


                return items
            })
            .sorted(by: { $0.x < $1.x })

        var checkedIndexes = [Tuple]()

        let finalNumbers: [String] = numberIndexes
            .compactMap { tuple -> String? in
                guard !checkedIndexes.contains(tuple) else {
                    return nil
                }
                checkedIndexes.append(tuple)

                var number = [matrix[tuple.x][tuple.y]]

                // check backworkds
                var index = tuple.y - 1
                var check = true

                while check {
                    checkedIndexes.append(.init(tuple.x, index))
                    if let num = Int(matrix[safe: tuple.x]?[safe: index] ?? "a") {
                        number.insert(String(num), at: 0)
                        index -= 1
                    } else {
                        check = false
                    }
                }

                // check forward
                check = true
                index = tuple.y + 1

                while check {
                    checkedIndexes.append(.init(tuple.x, index))
                    if let num = Int(matrix[safe: tuple.x]?[safe: index] ?? "a") {
                        number.append(String(num))
                        index += 1
                    } else {
                        check = false
                    }
                }
                return number.joined()
            }

        let sum = finalNumbers
            .compactMap { Int($0) }
            .reduce(0, +)

        print("Day 3-1: \(sum)")
    }

    static let sampleExtra = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

    static func executeExtra(sample: String = Self.sampleExtra) {
        let symbol = "*"
        let nonSymbols = "0123456789."
        let numbers = "0123456789"

        let matrix = sample
            .splitBreakLines()
            .map { line -> [String] in
                line
                    .split(separator: "")
                    .map { String($0) }
            }
        // find symbols indexes
        let symbolsIndexes = matrix
            .enumerated()
            .flatMap { rowI, row in
                row
                    .enumerated()
                    .filter { !nonSymbols.contains($1) }
                    .filter { $1 == symbol }
                    .map { (rowI, $0.offset) }
            }


        // double adjacent indexes
        let numberIndexes = symbolsIndexes
            .map { (x, y) -> [Tuple] in
                let filtered: [(Int, Int)] = [
                    (x-1, y-1), (x-1, y), (x-1, y+1),
                    (x, y-1), (x, y+1),
                    (x+1, y-1), (x+1, y), (x+1, y+1)
                ]
                    .filter {
                        ($0.0 >= 0 && $0.1 >= 0) &&
                        ($0.0 < matrix.count && $0.1 < matrix[0].count)
                    }

                let items: [Tuple] = filtered
                    .compactMap { (x, y) -> Tuple? in
                        guard matrix[x][y].contains(where: { numbers.contains($0) }) else {
                            return nil
                        }
                        return Tuple(x, y)
                    }
                return items.count >= 2 ? items : []
            }

        var checkedIndexes = [Tuple]()

        let finalNumbers: [Int] = numberIndexes
            .filter { $0.isNotEmpty }
            .compactMap { tuples -> Int? in
                let ts = tuples.compactMap { tuple -> String? in
                    guard !checkedIndexes.contains(tuple) else {
                        return nil
                    }
                    checkedIndexes.append(tuple)

                    var number = [matrix[tuple.x][tuple.y]]

                    // check backworkds
                    var index = tuple.y - 1
                    var check = true

                    while check {
                        checkedIndexes.append(.init(tuple.x, index))
                        if let num = Int(matrix[safe: tuple.x]?[safe: index] ?? "a") {
                            number.insert(String(num), at: 0)
                            index -= 1
                        } else {
                            check = false
                        }
                    }

                    // check forward
                    check = true
                    index = tuple.y + 1

                    while check {
                        checkedIndexes.append(.init(tuple.x, index))
                        if let num = Int(matrix[safe: tuple.x]?[safe: index] ?? "a") {
                            number.append(String(num))
                            index += 1
                        } else {
                            check = false
                        }
                    }

                    return number.joined()
                }
                    .compactMap { Int($0) }

                if ts.count == 2 {
                    return ts.reduce(1, { $0 * $1 })
                } else {
                    return nil
                }
            }

        let sum = finalNumbers
            .compactMap { Int($0) }
            .reduce(0, +)

        print("Day 3-2: \(sum)")
    }
}

extension Day3 {
    struct Tuple: Hashable {
        let x: Int
        let y: Int

        init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }
    }
}
