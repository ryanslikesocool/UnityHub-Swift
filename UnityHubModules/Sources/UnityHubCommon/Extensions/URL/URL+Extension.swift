import AppKit

public extension URL {
	func showInFinder() {
		NSWorkspace.shared.activateFileViewerSelecting([self])
	}

	var abbreviatingWithTildeInPath: String {
		(path(percentEncoded: false) as NSString).abbreviatingWithTildeInPath
	}

	func checkIsApplication() throws -> Bool {
		try resourceValues(forKeys: [.isApplicationKey]).isApplication == true
	}

	func checkIsDirectory() throws -> Bool {
		try resourceValues(forKeys: [.isDirectoryKey]).isDirectory == true
	}

	private func directoryTotalAllocatedSize(includingSubfolders: Bool = false) throws -> Int? {
		guard
			try checkIsDirectory(),
			try checkResourceIsReachable()
		else {
			return nil
		}
		if includingSubfolders {
			guard
				let enumerator = FileManager.default.enumerator(at: self, includingPropertiesForKeys: nil),
				let urls = enumerator.allObjects as? [URL]
			else {
				return nil
			}
			return try urls
				.lazy
				.reduce(0) { partialResult, element in
					try (element.resourceValues(forKeys: [.totalFileAllocatedSizeKey]).totalFileAllocatedSize ?? 0) + partialResult
				}
		}
		return try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil)
			.lazy
			.reduce(0) { partialResult, element in
				try (element.resourceValues(forKeys: [.totalFileAllocatedSizeKey])
					.totalFileAllocatedSize ?? 0) + partialResult
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
