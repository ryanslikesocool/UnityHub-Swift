import Foundation
import SFSymbolToolbox
import UnityHubResources

public extension SortOrder {
	enum Relative {
		case ascending
		case descending
	}
}

// MARK: - Sendable

extension SortOrder.Relative: Sendable { }

// MARK: - Equatable

extension SortOrder.Relative: Equatable { }

// MARK: - Hashable

extension SortOrder.Relative: Hashable { }

// MARK: - CustomLocalizedStringResourceConvertible

extension SortOrder.Relative: CustomLocalizedStringResourceConvertible {
	public var localizedStringResource: LocalizedStringResource {
		switch self {
			case .ascending: .sortOrderPicker.item.ascending
			case .descending: .sortOrderPicker.item.descending
		}
	}
}

// MARK: -

public extension SortOrder.Relative {
	var inverse: Self {
		switch self {
			case .ascending: .descending
			case .descending: .ascending
		}
	}

	var systemSymbolName: SystemSymbolName {
		switch self {
			case .ascending: .arrow_up
			case .descending: .arrow_down
		}
	}
}