//
//  String+Convenience.swift
//  Advent of Code
//
//  Created by Breno Valadão on 12/12/23.
//

import Foundation

extension String {
    func splitBreakLines() -> [String] {
        split(separator: "\n").map(String.init)
    }
}
