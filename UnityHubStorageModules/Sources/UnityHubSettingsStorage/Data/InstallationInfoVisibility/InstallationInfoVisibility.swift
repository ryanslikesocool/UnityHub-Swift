public enum InstallationInfoVisibility: UInt8 {
	case location
}

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
