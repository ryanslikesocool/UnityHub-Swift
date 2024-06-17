import AppKit

public extension URL {
	func showInFinder() {
		NSWorkspace.shared.activateFileViewerSelecting([self])
	}

	var abbreviatingWithTildeInPath: String {
		(path(percentEncoded: false) as NSString).abbreviatingWithTildeInPath
	}
}

public extension URL {
	var isValidUnityProject: Bool {
		let fileManager: FileManager = FileManager.default
		return
			fileManager.directoryExists(at: self) &&
			fileManager.directoryExists(at: appending(path: "Assets", directoryHint: .isDirectory)) &&
			fileManager.directoryExists(at: appending(path: "Packages", directoryHint: .isDirectory)) &&
			fileManager.directoryExists(at: appending(path: "ProjectSettings", directoryHint: .isDirectory))
	}
}

public extension URL {
	private func isDirectoryAndReachable() throws -> Bool {
		guard try resourceValues(forKeys: [.isDirectoryKey]).isDirectory == true else {
			return false
		}
		return try checkResourceIsReachable()
	}

	private func directoryTotalAllocatedSize(includingSubfolders: Bool = false) throws -> Int? {
		guard try isDirectoryAndReachable() else {
			return nil
		}
		if includingSubfolders {
			guard let urls = FileManager.default.enumerator(at: self, includingPropertiesForKeys: nil)?.allObjects as? [URL] else {
				return nil
			}
			return try urls.lazy.reduce(0) {
				try ($1.resourceValues(forKeys: [.totalFileAllocatedSizeKey]).totalFileAllocatedSize ?? 0) + $0
			}
		}
		return try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil).lazy.reduce(0) {
			try ($1.resourceValues(forKeys: [.totalFileAllocatedSizeKey])
				.totalFileAllocatedSize ?? 0) + $0
		}
	}

	func sizeOnDisk() throws -> String? {
		guard let size = try directoryTotalAllocatedSize(includingSubfolders: true) else {
			return nil
		}
		URL.byteCountFormatter.countStyle = .file
		guard let byteCount = URL.byteCountFormatter.string(for: size) else {
			return nil
		}

		return byteCount
	}

	private static let byteCountFormatter = ByteCountFormatter()
}
