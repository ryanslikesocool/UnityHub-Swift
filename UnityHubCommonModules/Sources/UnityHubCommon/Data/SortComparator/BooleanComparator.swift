import Foundation

/// A sort comparator capable of comparing Boolean values.
public struct BooleanComparator: SortComparator {
	public typealias Compared = Bool

	/// If the resulting order is forward or reverse.
	///
	/// | Order | Behavior |
	/// | - | - |
	/// | `.forward` | Sorted `false` to `true` |
	/// | `.reverse` | Sorted `true` to `false` |
	public var order: SortOrder

	/// Create a Boolean sort comparator.
	///
	/// | Order | Behavior |
	/// | - | - |
	/// | `.forward` | Sorted `false` to `true` |
	/// | `.reverse` | Sorted `true` to `false` |
	///
	/// - Parameter order: If the resulting order is forward or reverse.
	public init(order: SortOrder = .forward) {
		self.order = order
	}

	public func compare(_ lhs: Compared, _ rhs: Compared) -> ComparisonResult {
		switch (lhs, rhs, order) {
			case (true, false, .forward): .orderedDescending
			case (true, false, .reverse): .orderedAscending
			case (false, true, .forward): .orderedAscending
			case (false, true, .reverse): .orderedDescending
			default: .orderedSame
		}
	}
}