import Foundation

public extension ComparisonResult {
	init<Compared>(
		_ lhs: Compared,
		_ rhs: Compared
	) where
		Compared: Comparable
	{
		self = if lhs < rhs {
			.orderedAscending
		} else if lhs > rhs {
			.orderedDescending
		} else {
			.orderedSame
		}
	}
}
