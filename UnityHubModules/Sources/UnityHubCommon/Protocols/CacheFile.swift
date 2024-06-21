import Foundation

public protocol CacheFile: GlobalFile {
	static var fileName: String { get }
}

// MARK: - Default Implementation

public extension CacheFile {
	static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.hashValue == rhs.hashValue
	}

	static var fileURL: URL {
		Constant.applicationSupportDirectory
			.appending(path: fileName, directoryHint: .notDirectory)
	}
}
