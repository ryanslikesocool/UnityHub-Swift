import Foundation

public struct MultiComparator<Compared>: SortComparator {
	public var order: SortOrder

	public let comparators: [any SortComparator<Compared>]

	public init(
		comparators: some Sequence<any SortComparator<Compared>>,
		order: SortOrder = .forward
	) {
		self.comparators = Array(comparators)
		self.order = order
	}

	public func compare(_ lhs: Compared, _ rhs: Compared) -> ComparisonResult {
		var comparisonResult: ComparisonResult = .orderedSame

		loop: for comparator in comparators {
			switch comparator.compare(lhs, rhs) {
				case .orderedSame:
					continue
				case let other:
					comparisonResult = other
					break loop
			}
		}

		return switch order {
			case .forward: comparisonResult
			case .reverse: comparisonResult.inverse
		}
	}
}

// MARK: - Equatable

extension MultiComparator: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.order == rhs.order
			&& lhs.comparators.count == rhs.comparators.count
			&& zip(lhs.comparators, rhs.comparators).allSatisfy(areEqual)
	}
}

// MARK: - Hashable

extension MultiComparator: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(order)
		for comparator in comparators {
			hasher.combine(comparator)
		}
	}
}
