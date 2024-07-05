import AppKit

public extension URL {
	@inlinable func showInFinder() {
		NSWorkspace.shared.activateFileViewerSelecting([self])
	}

	@inlinable var abbreviatingWithTildeInPath: String {
		(path(percentEncoded: false) as NSString).abbreviatingWithTildeInPath
	}
}

public extension URL {
	@inlinable func isApplication() throws -> Bool {
		try resourceValues(forKeys: [.isApplicationKey]).isApplication == true
	}

	@inlinable func isDirectory() throws -> Bool {
		try resourceValues(forKeys: [.isDirectoryKey]).isDirectory == true
	}

	private func directoryTotalAllocatedSize(includingSubfolders: Bool = false) throws -> Int? {
		guard
			try isDirectory(),
			try checkResourceIsReachable()
		else {
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
		ByteCountFormatter.shared.countStyle = .file
		guard let byteCount = ByteCountFormatter.shared.string(for: size) else {
			return nil
		}

		return byteCount
	}
}
