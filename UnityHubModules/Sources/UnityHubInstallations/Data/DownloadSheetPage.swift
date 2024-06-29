enum DownloadSheetPage: UInt8 {
	case recommended
	case official
	case prerelease
	case archive
}

// MARK: - Hashable

extension DownloadSheetPage: Hashable { }

// MARK: - Identifiable

extension DownloadSheetPage: Identifiable {
	var id: RawValue { rawValue }
}
