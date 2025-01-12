import Foundation

public extension KeyPathComparator {
	/// - Parameters:
	///   - keyPath: <#keyPath description#>
	///   - comparator: The comparator used to compare two non-`nil` objects.
	///   - optionalBehavior: Determine how to handle `nil` objects when compared against non-`nil` objects.
	init<Value, Comparator>(
		_ keyPath: any KeyPath<Compared, Value?> & Sendable,
		comparator: Comparator,
		optionalBehavior: borrowing OptionalSortBehavior = .late
	) where
		Comparator: SortComparator,
		Comparator.Compared == Value
	{
		self.init(
			keyPath,
			comparator: OptionalComparator<Value>(comparator: comparator, optionalBehavior: optionalBehavior),
			order: comparator.order
		)
	}

	/// - Parameters:
	///   - keyPath: <#keyPath description#>
	///   - optionalBehavior: Determine how to handle `nil` objects when compared against non-`nil` objects.
	///   - order: If the resulting order is forward or reverse.
	init<Value>(
		_ keyPath: any KeyPath<Compared, Value?> & Sendable,
		optionalBehavior: borrowing OptionalSortBehavior = .late,
		order: borrowing SortOrder = .forward
	) where
		Value: Comparable
	{
		self.init(
			keyPath,
			comparator: OptionalComparator<Value>(optionalBehavior: optionalBehavior, order: order),
			order: order
		)
	}
}
