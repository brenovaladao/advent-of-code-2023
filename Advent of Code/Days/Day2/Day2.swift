//
//  Day2.swift
//  Advent of Code
//
//  Created by Breno Valadão on 12/12/23.
//

import Foundation

enum Day2 {
    static let sampleChallenge = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """

    static func executeChallenge(sample: String = Self.sampleChallenge) {
        // Game 2: 2 green, 1 blue; 1 red, 2 green; 3 red, 1 blue; 2 blue, 1 green, 8 red; 1 green, 10 red; 10 red

        // MAX
        // 12 red
        // 13 green
        // 14 blue

        let maxRed = 12
        let maxGreen = 13
        let maxBlue = 14

        var total = 0

        sample
            .splitBreakLines()
            .forEach { games in
                var isPossible: Bool = true
                let info = games.split(separator: ":")
                info[1]
                    .split(separator: ";") // games
                    .forEach { game in
                        game
                            .split(separator: ",")
                            .forEach { play in
                                switch play {
                                case _ where play.range(of: "blue") != nil:
                                    if !checkIfPossible(str: String(play), max: maxBlue) {
                                        isPossible = false
                                        break
                                    }
                                case _ where play.range(of: "green") != nil:
                                    if !checkIfPossible(str: String(play), max: maxGreen) {
                                        isPossible = false
                                        break
                                    }
                                case _ where play.range(of: "red") != nil:
                                    if !checkIfPossible(str: String(play), max: maxRed) {
                                        isPossible = false
                                        break
                                    }
                                default:
                                    break
                                }
                            }
                    }

                if isPossible {
                    if let sum = info[0]
                        .split(separator: " ")
                        .last,
                       let value = Int(String(sum)) {
                        total += value
                    }

                }
            }

        print("Day 2-1: \(total)")
    }

    static let sampleExtra = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """

    static func executeExtra(sample: String = Self.sampleExtra) {
        // Game 2: 10 green,  1 red,  5 blue;
        //          5 green; 12 red,  6 blue;
        //          4 green,  4 red, 10 blue;
        //
        // 10g, 12r, 10b

        let total = sample
            .splitBreakLines()
            .map { games -> Int in
                let info = games.split(separator: ":")

                var mRed: Int = 0
                var mBlue: Int = 0
                var mGreen: Int = 0

                info[1]
                    .split(separator: ";") // games
                    .forEach { game in
                        game
                            .split(separator: ",")
                            .forEach { play in
                                switch play {
                                case _ where play.range(of: "blue") != nil:
                                    let blue = getValue(str: String(play))
                                    if blue > mBlue {
                                        mBlue = blue
                                    }
                                case _ where play.range(of: "green") != nil:
                                    let green = getValue(str: String(play))
                                    if green > mGreen {
                                        mGreen = green
                                    }
                                case _ where play.range(of: "red") != nil:
                                    let red = getValue(str: String(play))
                                    if red > mRed {
                                        mRed = red
                                    }
                                default:
                                    break
                                }
                            }
                    }

                let res = [mRed, mBlue, mGreen]
                    .filter { $0 != 0 }
                    .reduce(1, { $0 * $1 })

                return res
            }
            .reduce(0, +)


        print("Day 2-2: \(total)")

    }
}

extension Day2 {
    static func checkIfPossible(str: String, max: Int) -> Bool {
        if let first = str
            .split(separator: " ")
            .first,
           let value = Int(first),
           max < value
        {
            return false
        } else {
            return true
        }
    }

    static func getValue(str: String) -> Int {
        if let first = str
            .split(separator: " ")
            .first,
           let value = Int(first)
        {
            return value
        } else {
            return 0
        }
    }
}
