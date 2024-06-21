import SwiftUI

public extension SortOrder {
	var opposite: Self {
		switch self {
			case .forward: .reverse
			case .reverse: .forward
		}
	}
}
