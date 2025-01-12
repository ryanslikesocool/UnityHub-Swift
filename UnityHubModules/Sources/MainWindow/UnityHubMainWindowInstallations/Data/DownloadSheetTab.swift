import Foundation
import UnityHubResources

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
	public var id: RawValue { rawValue }
}

// MARK: - CustomLocalizedStringResourceConvertible

extension DownloadSheetTab: CustomLocalizedStringResourceConvertible {
	public var localizedStringResource: LocalizedStringResource {
		switch self {
			case .recommended: .downloadSheet.group.recommended
			case .official: .downloadSheet.group.official
			case .prerelease: .downloadSheet.group.prerelease
			case .archive: .downloadSheet.group.archive
		}
	}
}