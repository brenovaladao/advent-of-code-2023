//
//  Day1.swift
//  advent-of-code
//
//  Created by Breno Valadão on 12/12/23.
//

import Foundation

enum Day1 {
    static let sampleChallenge = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

    static func executeChallenge(sample: String = Self.sampleChallenge) {
        let res = sample
            .splitBreakLines()
            .map { str -> Int in
                let numbers = str
                    .components(separatedBy: .decimalDigits.inverted)
                    .joined()
                    .compactMap(String.init)
                return Int((numbers.first ?? "") + (numbers.last ?? "")) ?? 0
            }
            .reduce(0, +)

        print("Day 1-1: \(res)")
    }


    static let sampleExtra = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """

    static func executeExtra(sample: String = Self.sampleExtra) {
        let firstMap = sample
            .splitBreakLines()
            .map { str -> String in
                var items = [(String.Index, String)]()

                Numbers.allCases.forEach {
                    var searchStartIndex = str.startIndex
                    while let range = str.range(of: $0.rawValue, range: searchStartIndex..<str.endIndex) {
                        items.append((range.lowerBound, $0.number))
                        searchStartIndex = range.upperBound
                    }

                    searchStartIndex = str.startIndex
                    while let range = str.range(of: $0.number, range: searchStartIndex..<str.endIndex) {
                        items.append((range.lowerBound, $0.number))
                        searchStartIndex = range.upperBound
                    }
                }
                let ret = items
                    .sorted(by: { $0.0 < $1.0 })
                    .map { $0.1 }
                    .joined()

                return ret
            }
        let res = firstMap
            .map {
                let numbers = $0
                    .components(separatedBy: CharacterSet.decimalDigits.inverted)
                    .joined()
                    .compactMap { String($0) }
                return Int((numbers.first ?? "") + (numbers.last ?? "")) ?? 0
            }
            .reduce(0, +)

        print("Day 1-2: \(res)")
    }
}

extension Day1 {
    enum Numbers: String, CaseIterable {
        case one, two, three, four, five, six, seven, eight, nine

        init?(rawValue: String) {
            switch rawValue {
            case "one", "1": self = .one
            case "two", "2": self = .two
            case "three", "3": self = .three
            case "four", "4": self = .four
            case "five", "5": self = .five
            case "six", "6": self = .six
            case "seven", "7": self = .seven
            case "eight", "8": self = .eight
            case "nine", "9": self = .nine
            default: return nil
            }
        }

        var number: String {
            switch self {
            case .one: "1"
            case .two: "2"
            case .three: "3"
            case .four: "4"
            case .five: "5"
            case .six: "6"
            case .seven: "7"
            case .eight: "8"
            case .nine: "9"
            }
        }
    }
}
