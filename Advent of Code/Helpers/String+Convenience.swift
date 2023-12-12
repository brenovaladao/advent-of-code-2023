//
//  String+Convenience.swift
//  Advent of Code
//
//  Created by Breno Valadão on 12/12/23.
//

import Foundation

extension String {
    func splitBreakLines() -> [String] {
        split("\n")
    }

    func split(_ value: String) -> [String] {
        split(separator: value).map(String.init)
    }
}
