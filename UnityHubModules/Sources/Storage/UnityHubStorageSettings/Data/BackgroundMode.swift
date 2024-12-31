import Foundation

public enum BackgroundMode: String {
	case none
	case hide
	case quit
}

// MARK: - Sendable

extension BackgroundMode: Sendable { }

// MARK: - Equatable

extension BackgroundMode: Equatable { }

// MARK: - Hashable

extension BackgroundMode: Hashable { }

// MARK: - Identifiable

extension BackgroundMode: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension BackgroundMode: Codable { }

// MARK: - Localized

extension BackgroundMode: CustomLocalizedStringResourceConvertible {
	public var localizedStringResource: LocalizedStringResource {
		switch self {
			case .none: .backgroundModePicker.item.none
			case .hide: .backgroundModePicker.item.hide
			case .quit: .backgroundModePicker.item.quit
		}
	}
}