import Foundation

struct AppSettings_General: PlistDictionary {
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

extension AppSettings_General {
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

extension AppSettings_General {
    enum Appearance: String, Identifiable, CaseIterable, Unwrappable {
        case automatic = "Automatic"
        case light = "Light"
        case dark = "Dark"

        var id: String { rawValue }

        init(unwrap any: Any?, _ default: AppSettings_General.Appearance) {
            let new = .init(rawValue: any as? String ?? `default`.rawValue) ?? `default`
            self = new
        }
    }
}
