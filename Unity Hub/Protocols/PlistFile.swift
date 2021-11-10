import Foundation

protocol PlistFile: ObservableObject {
    static var fileName: String { get }
    static var fileDirectory: URL { get }
    static var filePath: URL { get }

    static func load() -> Self
    func save()

	init()
    init(dictionary: [String: Any])
    func saveToDictionary() -> [String: Any]
}

extension PlistFile {
    static func load() -> Self {
        do {
            let plistData = try Data(contentsOf: filePath)
            let dictionary = try PropertyListSerialization.propertyList(from: plistData, options: [.mutableContainersAndLeaves], format: .none) as! [String: Any]
            return Self(dictionary: dictionary)
        } catch {
            print("Could not read plist at \(filePath).  Creating a new one with default values.  Error: \(error)")
            let result = Self()
            result.save()
            return result
        }
    }

    func save() {
        if !FileManager.default.fileExists(atPath: Self.fileDirectory.path) {
            do {
                try FileManager.default.createDirectory(atPath: Self.fileDirectory.path, withIntermediateDirectories: true)
            } catch {
                print("Could not create directory at \(Self.fileDirectory.path).  Error: \(error)")
            }
        }
        if !FileManager.default.fileExists(atPath: Self.filePath.path) {
            FileManager.default.createFile(atPath: Self.filePath.path, contents: nil)
        }

        do {
            let dictionary = saveToDictionary()
            let data = try PropertyListSerialization.data(fromPropertyList: dictionary, format: .xml, options: 0)
            try data.write(to: Self.filePath)
			print("Saved file of type '\(Self.self)' to path '\(Self.filePath)'")
		} catch {
            print("Couldn't save settings file to \(Self.fileName)", error)
        }
    }
}
