import Foundation

extension URL: Comparable {
	public static func < (lhs: Self, rhs: Self) -> Bool {
		lhs.path() < rhs.path()
	}
}
