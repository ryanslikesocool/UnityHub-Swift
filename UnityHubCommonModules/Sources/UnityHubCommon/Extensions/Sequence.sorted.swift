import Foundation

public extension Sequence {
	func sorted<Value>(
		by keyPath: any KeyPath<Element, Value> & Sendable,
		order: SortOrder = .forward
	) -> [Element] where
		Value: Comparable
	{
		let comparator = KeyPathComparator(keyPath, order: order)
		return sorted(using: comparator)
	}

	func sorted<Value>(
		by keyPath: any KeyPath<Element, Value?> & Sendable,
		optionalBehavior: OptionalSortBehavior = .late,
		order: SortOrder = .forward
	) -> [Element] where
		Value: Comparable
	{
		let comparator = KeyPathComparator(
			keyPath,
			optionalBehavior: optionalBehavior,
			order: order
		)
		return sorted(using: comparator)
	}

	func sorted(
		by areInIncreasingOrder: (Element, Element) throws -> Bool,
		order: SortOrder = .forward
	) rethrows -> [Element] {
		switch order {
			case .forward: try sorted(by: areInIncreasingOrder)
			case .reverse: try sorted(by: { lhs, rhs in try !areInIncreasingOrder(lhs, rhs) })
		}
	}

	func sorted<Value>(
		by value: (Element) -> Value?,
		optionalBehavior: OptionalSortBehavior = .late,
		order: SortOrder = .forward
	) -> [Element] where
		Value: Comparable
	{
		let comparator = OptionalComparator<Value>(optionalBehavior: optionalBehavior, order: order)

		return sorted { lhs, rhs in
			comparator.compare(value(lhs), value(rhs)) == .orderedAscending
		}
	}

	func sorted<Value>(
		by value: (Element) throws -> Value,
		order: SortOrder = .forward
	) rethrows -> [Element] where
		Value: Comparable
	{
		switch order {
			case .forward:
				try sorted { lhs, rhs in
					try value(lhs) < value(rhs)
				}
			case .reverse:
				try sorted { lhs, rhs in
					try value(lhs) > value(rhs)
				}
		}
	}

	func sorted<S>(
		using comparators: S,
		order: SortOrder = .forward
	) -> [Element] where
		S: Sequence<any SortComparator<Element>>
	{
		let multiComparator = MultiComparator<Element>(comparators: comparators, order: order)
		return sorted(using: multiComparator)
	}
}
