import Foundation

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

    /// Returns second element from collection
    var second: Element? {
        dropFirst().first
    }

    /// Use this for checks instead of !.isEmpty that is triggered as warning by Swiftlint
    var isNotEmpty: Bool {
        !isEmpty
    }
}
