import Foundation

public extension ComparisonResult {
	/// The inverse of the comparison result.
	///
	/// | Value | Inverse |
	/// | - | - |
	/// | ``orderedAscending`` | ``orderedDescending`` |
	/// | ``orderedDescending`` | ``orderedAscending`` |
	/// | ``orderedSame`` | ``orderedSame`` |
	@inlinable
	var inverse: Self {
		// `rawValue` works out nicely so `inverse.rawValue` == `rawValue * -1`
		Self(rawValue: -rawValue)!

		// above operation basically does this
//		switch self {
//			case .orderedAscending: .orderedDescending
//			case .orderedDescending: .orderedAscending
//			case .orderedSame: .orderedSame
//		}
	}
}