import SwiftUI

public extension SortOrder {
	@inlinable
	var inverse: Self {
		switch self {
			case .forward: .reverse
			case .reverse: .forward
		}
	}
}
