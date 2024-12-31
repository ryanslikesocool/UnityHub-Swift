import AppKit

public enum Appearance: UInt8 {
	case system
	case light
	case dark
}

// MARK: - Sendable

extension Appearance: Sendable { }

// MARK: - Equatable

extension Appearance: Equatable { }

// MARK: - Hashable

extension Appearance: Hashable { }

// MARK: - Identifiable

extension Appearance: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension Appearance: Codable { }

// MARK: -

extension Appearance: CustomLocalizedStringResourceConvertible {
	public var localizedStringResource: LocalizedStringResource {
		switch self {
			case .system: .appearancePicker.item.system
			case .light: .appearancePicker.item.light
			case .dark: .appearancePicker.item.dark
		}
	}
}

// MARK: -

public extension Appearance {
	func apply() {
		Task { @MainActor in
			NSApp.appearance = switch self {
				case .light: NSAppearance(named: .aqua)
				case .dark: NSAppearance(named: .darkAqua)
				default: nil
			}
		}
	}
}
