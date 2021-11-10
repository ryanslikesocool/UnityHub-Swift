import Foundation

struct ProjectDataWrapper: Codable {
    var path: String?
    var name: String?
    var version: UnityVersionWrapper?
    var emoji: String?
    var pinned: Bool?

    init(original: ProjectData) {
        path = original.path
        name = original.name
        version = UnityVersionWrapper(original: original.version)
        emoji = original.emoji
        pinned = original.pinned
    }

    func unwrap() -> ProjectData {
        var result = ProjectData()

        result.path = path ?? #"~/New Unity Project"#
        result.name = name ?? "New Unity Project"
        result.version = version?.unwrap() ?? .null
        result.emoji = emoji ?? "❓"
        result.pinned = pinned ?? false

        return result
    }

    static func wrap(_ originals: [ProjectData]) -> [ProjectDataWrapper] {
        var result: [ProjectDataWrapper] = []
        for data in originals {
            result.append(ProjectDataWrapper(original: data))
        }
        return result
    }
}
