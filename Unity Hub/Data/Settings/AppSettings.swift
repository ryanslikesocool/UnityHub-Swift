import Foundation

final class AppSettings: ObservableObject, PlistFile {
	static let shared: AppSettings = .init(url: AppSettings.filePath) ?? .init()

    @Published var general: General = .init() { didSet { save() }}
}

extension AppSettings {
    static let fileName: String = "Settings.plist"
    static var fileDirectory: URL { FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent("UnityHub", isDirectory: true) }
    static var filePath: URL { fileDirectory.appendingPathComponent(fileName, isDirectory: false) }

    func save() {
        save(to: AppSettings.filePath)
    }

    convenience init(dictionary: [String: Any]) {
		self.init()
		general = .init(any: dictionary["General"])
    }

    func saveToDictionary() -> [String: Any] {
        [
            "General": general.saveToDictionary(),
        ]
    }
}
