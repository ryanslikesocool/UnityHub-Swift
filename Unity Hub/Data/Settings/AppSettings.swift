import Foundation

final class AppSettings: PlistFile {
    static let shared: AppSettings = load()

    @Published var general: AppSettings_General = .init() { didSet { save() }}
}

extension AppSettings {
    static let fileName: String = "Settings.plist"
    static var fileDirectory: URL { FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent("UnityHub", isDirectory: true) }
    static var filePath: URL { fileDirectory.appendingPathComponent(fileName, isDirectory: false) }

    convenience init(dictionary: [String: Any]) {
		general = .init(dictionary["General"]) ?? general
    }

    func saveToDictionary() -> [String: Any] {
        [
            "General": general.saveToDictionary(),
        ]
    }
}
