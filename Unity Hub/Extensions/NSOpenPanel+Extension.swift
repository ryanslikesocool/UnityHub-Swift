import AppKit
import Foundation
import UniformTypeIdentifiers

extension NSOpenPanel {
	static func openFolder(completion: @escaping (_ result: Result<String, Error>) -> Void) {
		let panel = NSOpenPanel()
		panel.allowsMultipleSelection = false
		panel.canChooseFiles = false
		panel.canChooseDirectories = true
		panel.begin { result in
			if result == .OK, let url = panel.urls.first {
				completion(.success(url.path))
			} else {
				completion(.failure(
					NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get folder location"])
				))
			}
		}
	}

	static func openFolder(success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
		openFolder { result in
			if case let .success(path) = result {
				success(path)
			} else if case let .failure(error) = result {
				failure(error)
			}
		}
	}

	static func openFile(types: [UTType], completion: @escaping (_ result: Result<String, Error>) -> Void) {
		let panel = NSOpenPanel()
		panel.allowsMultipleSelection = false
		panel.canChooseFiles = true
		panel.allowedContentTypes = types
		panel.canChooseDirectories = false
		panel.begin { result in
			if result == .OK, let url = panel.urls.first {
				completion(.success(url.path))
			} else {
				completion(.failure(
					NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get folder location"])
				))
			}
		}
	}

	static func openFile(types: [UTType], success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
		openFile(types: types) { result in
			if case let .success(path) = result {
				success(path)
			} else if case let .failure(error) = result {
				failure(error)
			}
		}
	}
}
