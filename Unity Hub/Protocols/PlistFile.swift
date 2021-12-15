import Foundation

protocol PlistFile: PlistDictionary {
	init?(url: URL)
	func save(to url: URL)
}

extension PlistFile {
	init?(url: URL) {
		do {
			let plistData = try Data(contentsOf: url)
			let dictionary = try PropertyListSerialization.propertyList(from: plistData, options: [.mutableContainersAndLeaves], format: .none) as! [String: Any]
			self.init(dictionary: dictionary)
		} catch {
			return nil
		}
	}

	func save(to url: URL) {
		let fileManager = FileManager.default

		do {
			var isDirectory: ObjCBool = true
			let folder = url.deletingLastPathComponent()
			if !fileManager.fileExists(atPath: folder.path, isDirectory: &isDirectory) {
				try fileManager.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
			}

			if !fileManager.fileExists(atPath: url.path) {
				fileManager.createFile(atPath: url.path, contents: nil, attributes: nil)
			}

			let dictionary = saveToDictionary()
			let data = try PropertyListSerialization.data(fromPropertyList: dictionary, format: .xml, options: 0)
			try data.write(to: url)
		} catch {
			print("Couldn't save file to \(url)", error)
		}
	}
}
