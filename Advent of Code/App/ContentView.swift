//
//  ContentView.swift
//  Advent of Code
//
//  Created by Breno Valadão on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Advent of code 2023")
                    .font(.title)

                makeDay(day: 1) {
                    // Day 1-1: 55621
                    Day1.executeChallenge(sample: input())
                } extra: {
                    // Day 1-2: 53592
                    Day1.executeExtra(sample: input())
                }

                makeDay(day: 2) {
                    // Day 2-1: 2720
                    Day2.executeChallenge(sample: input2())
                } extra: {
                    // Day 2-2: 71535
                    Day2.executeExtra(sample: input2())
                }

                makeDay(day: 3) {
                    // Day 3-1: 556057
                    Day3.executeChallenge(sample: input3())
                } extra: {
                    // Day 3-2: 82824352
                    Day3.executeExtra(sample: input3())
                }

                makeDay(day: 4) {
                    // Day 4-1: 22193
                    Day4.executeChallenge(sample: input4())
                } extra: {
                    // Day 4-2: ?
                    Day4.executeExtra(sample: input4())
                }
            }
            .padding()
        }
    }

    func makeDay(
        day: Int,
        challenge: @escaping () -> Void,
        extra: @escaping () -> Void
    ) -> some View {
        HStack {
            Text("Day \(day)")
            Button("Challenge", action: challenge)
            Button("Extra Challenge", action: extra)

            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
