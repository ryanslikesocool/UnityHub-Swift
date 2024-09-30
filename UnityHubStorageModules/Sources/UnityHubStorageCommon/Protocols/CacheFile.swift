import Foundation
import UnityHubCommon

public protocol CacheFile: GlobalFile {
	static var category: CacheCategory { get }
}

// MARK: - Default Implementation

public extension CacheFile {
	static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.hashValue == rhs.hashValue
	}

	static var fileURL: URL {
		URL.persistentStorageDirectory
			.appending(path: "\(category.fileName).plist", directoryHint: .notDirectory)
	}
}
