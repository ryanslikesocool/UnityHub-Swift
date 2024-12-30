import AppKit

public enum Appearance: UInt8 {
	case automatic
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
