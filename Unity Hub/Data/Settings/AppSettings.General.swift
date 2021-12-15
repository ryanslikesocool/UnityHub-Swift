import Foundation

extension AppSettings {
    struct General {
        var appearance: Appearance = .automatic { didSet {
            AppDelegate.setAppearance(from: appearance.rawValue)
        }}

        var useEmoji: Bool = true
        var usePins: Bool = true
        var showLocation: Bool = true
        var showFileSize: Bool = true
        var useSmallSidebar: Bool = true
        var showSidebarCount: Bool = true
    }
}

extension AppSettings.General: PlistDictionary {
    init(dictionary: [String: Any]) {
        appearance = Appearance(unwrap: dictionary["Appearance"], appearance)
        useEmoji = Bool(unwrap: dictionary["Use Emoji"], useEmoji)
        usePins = Bool(unwrap: dictionary["Use Pins"], usePins)
        showLocation = Bool(unwrap: dictionary["Show Location"], showLocation)
        showFileSize = Bool(unwrap: dictionary["Show File Size"], showFileSize)
        useSmallSidebar = Bool(unwrap: dictionary["Use Small Sidebar"], useSmallSidebar)
        showSidebarCount = Bool(unwrap: dictionary["Show Sidebar Count"], showSidebarCount)
    }

    func saveToDictionary() -> [String: Any] {
        [
            "Appearance": appearance.rawValue,
            "Use Emoji": useEmoji,
            "Use Pins": usePins,
            "Show Location": showLocation,
            "Show File Size": showFileSize,
            "Use Small Sidebar": useSmallSidebar,
            "Show Sidebar Count": showSidebarCount,
        ]
    }
}

extension AppSettings.General {
    enum Appearance: String, Identifiable, CaseIterable {
        case automatic = "Automatic"
        case light = "Light"
        case dark = "Dark"

        var id: String { rawValue }
    }
}
