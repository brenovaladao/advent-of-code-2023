//
//  Day4.swift
//  Advent of Code
//
//  Created by Breno Valadão on 12/12/23.
//

import Foundation
enum Day4 {
    // 4:1 -> 13
    // 4:2 -> 30
    static let sampleChallenge = """
    Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
    Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
    Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
    Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
    Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    """
    // 4, 2, 2, 1, 0, 0

    static func executeChallenge(sample: String = Self.sampleChallenge) {
        // split lines
        // get cards
        // get winning[0] get mine[1]
        // get intersection and than count

        // card point (0...matchingNumbersCount).reduce(1) { $0 =* 2 }
        // final score cardPoints.reduce(0, +)

        let result = sample
            .splitBreakLines()
            .map { card -> Int in
                let values = card.split("|")

                let winninNumbers = Set(values[0]
                    .split(":")[1]
                    .split(" ")
                    .compactMap(Int.init))

                let myNumbers = Set(values[1]
                    .split(" ")
                    .compactMap(Int.init))

                let count = winninNumbers.intersection(myNumbers).count
                guard count > 0 else {
                    return 0
                }

                return (1..<count)
                    .reduce(1) { acc, _ in acc * 2 }
            }
            .reduce(0, +)


        print("Day 4-1: \(result)")
    }

    static func executeExtra(sample: String = Self.sampleChallenge) {
        let cards: [(Set<Int>, [Int])] = sample
            .splitBreakLines()
            .map { card in
                let values = card.split("|")
                let section = values[0].split(":")
                let winninNumbers = Set(section[1].split(" ")
                    .compactMap(Int.init))
                let myNumbers = values[1]
                    .split(" ")
                    .compactMap(Int.init)
                return (winninNumbers, myNumbers)
            }

        // initialize all with 1
        var cardAmount = Array(repeating: 1, count: cards.count)
        
        cards.enumerated().forEach {
            let (index, (winning, myNumbers)) = $0
            var found = 0
            for value in myNumbers {
                if winning.contains(value) {
                    found += 1
                }
            }

            guard found > 0 else {
                return
            }

            print("\n\nindex \(index)")
            print("range \(1...found), total rows: \(cards.count)")

            // where - check if out of bounds for all cards
            for offset in 1...found where offset + index < cards.count {
                // next row index
                let newIndex = index + offset
                print("- newIndex \(offset) + \(index) = \(newIndex)  ||| \(cardAmount[newIndex]) += \(cardAmount[index])")
                // adds ammount of cards to the next row
                cardAmount[newIndex] += cardAmount[index]
            }
            print("- card ammount \(cardAmount)")
        }

        print("Day 4-2: \(cardAmount.reduce(0, +))")
    }
}
