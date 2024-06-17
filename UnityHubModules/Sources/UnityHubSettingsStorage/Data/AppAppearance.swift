import AppKit

public enum AppAppearance: UInt8 {
	case automatic
	case light
	case dark

	public init(rawValue: RawValue) {
		self = switch rawValue {
			case 1: .light
			case 2: .dark
			default: .automatic
		}
	}
}

// MARK: - Hashable

extension AppAppearance: Hashable { }

// MARK: - Identifiable

extension AppAppearance: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension AppAppearance: Codable { }

// MARK: - CaseIterable

extension AppAppearance: CaseIterable { }

// MARK: -

extension AppAppearance {
	var nsAppearance: NSAppearance? {
		switch self {
			case .light: NSAppearance(named: .aqua)
			case .dark: NSAppearance(named: .darkAqua)
			default: nil
		}
	}
}
