enum DownloadSheetTab: UInt8 {
	case recommended
	case official
	case prerelease
	case archive
}

// MARK: - Sendable

extension DownloadSheetTab: Sendable { }

// MARK: - Equatable

extension DownloadSheetTab: Equatable { }

// MARK: - Hashable

extension DownloadSheetTab: Hashable { }

// MARK: - Identifiable

extension DownloadSheetTab: Identifiable {
	var id: RawValue { rawValue }
}
