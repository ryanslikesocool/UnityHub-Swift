public enum InstallationInfoVisibility: UInt8 {
	case location
	case badge
}

// MARK: - Sendable

extension InstallationInfoVisibility: Sendable { }

// MARK: - Equatable

extension InstallationInfoVisibility: Equatable { }

// MARK: - Hashable

extension InstallationInfoVisibility: Hashable { }

// MARK: - Identifiable

extension InstallationInfoVisibility: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension InstallationInfoVisibility: Codable { }

// MARK: - CaseIterable

extension InstallationInfoVisibility: CaseIterable { }
