import Foundation

struct ProjectDataV2 {
	static let empty = ProjectDataV2()

    var path: String = "UNKNOWN"
    var name: String = "UNKNOWN"
	var version: Version = .zero
    var emoji: String = "❓"
    var pinned: Bool = false
}

extension ProjectDataV2: PlistDictionary {
    init(dictionary: [String: Any]) {
        path = String(unwrap: dictionary["Path"], "UNKNOWN")
        name = String(unwrap: dictionary["Name"], "UNKNOWN")
        version = Version(string: String(unwrap: dictionary["Version"], Version.zero.description))
        emoji = String(unwrap: dictionary["Emoji"], "❓")
        pinned = Bool(unwrap: dictionary["Pinned"], false)
    }

    func saveToDictionary() -> [String: Any] {
        [
            "Path": path,
            "Name": name,
            "Version": version.description,
            "Emoji": emoji,
            "Pinned": pinned,
        ]
    }
}
