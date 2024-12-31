import SwiftUI

public extension SortOrder {
	var inverse: Self {
		switch self {
			case .forward: .reverse
			case .reverse: .forward
		}
	}
}
