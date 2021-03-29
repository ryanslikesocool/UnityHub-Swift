//
//  ProjectDataDecoder.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/29/21.
//

import Foundation

struct ProjectDataDecoder: Codable {
    var path: String?
    var name: String?
    var version: UnityVersionDecoder?
    var emoji: String?
    var pinned: Bool?

    func toProjectData() -> ProjectData {
        var result = ProjectData()

        result.path = path ?? #"~/New Unity Project"#
        result.name = name ?? "New Unity Project"
        result.version = version?.toUnityVersion() ?? .null
        result.emoji = emoji ?? "❓"
        result.pinned = pinned ?? false

        return result
    }
}
