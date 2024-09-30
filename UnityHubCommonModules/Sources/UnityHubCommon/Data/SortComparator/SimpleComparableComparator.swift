import Foundation

/// A sort comparator that uses the compared object's `Comparable` implementation.
public struct SimpleComparableComparator<Compared>: SortComparator where
	Compared: Comparable
{
	/// If the resulting order is forward or reverse.
	public var order: SortOrder

	/// - Parameter order: If the resulting order is forward or reverse.
	public init(order: SortOrder) {
		self.order = order
	}

	public func compare(_ lhs: Compared, _ rhs: Compared) -> ComparisonResult {
		let forwardResult: ComparisonResult

		if lhs < rhs {
			forwardResult = .orderedAscending
		} else if lhs > rhs {
			forwardResult = .orderedDescending
		} else {
			// `.orderedSame` inverse is identical, early return
			return .orderedSame
		}

		return switch order {
			case .forward: forwardResult
			case .reverse: forwardResult.inverse
		}
	}
}
