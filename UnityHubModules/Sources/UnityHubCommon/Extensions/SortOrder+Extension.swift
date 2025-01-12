import Foundation
import SFSymbolToolbox

// MARK: - CustomLocalizedStringResourceConvertible

extension SortOrder: @retroactive CustomLocalizedStringResourceConvertible {
	public var localizedStringResource: LocalizedStringResource {
		switch self {
			case .forward: .sortOrderPicker.item.ascending
			case .reverse: .sortOrderPicker.item.descending
		}
	}
}

// MARK: -

public extension SortOrder {
	var inverse: Self {
		switch self {
			case .forward: .reverse
			case .reverse: .forward
		}
	}

	var systemSymbolName: SystemSymbolName {
		switch self {
			case .forward: .arrow_up
			case .reverse: .arrow_down
		}
	}
}
