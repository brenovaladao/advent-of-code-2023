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
            VStack {
                Text("Advent of code 2023")
                    .font(.title)

                makeDay(day: 1) {
                    Day1.executeChallenge(sample: input())
                } extra: {
                    Day1.executeExtra(sample: input())
                }
            }
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
        }
    }
}

#Preview {
    ContentView()
}
