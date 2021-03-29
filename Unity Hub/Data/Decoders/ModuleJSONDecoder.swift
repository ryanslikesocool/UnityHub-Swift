//
//  ModuleJSONDecoder.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/29/21.
//

import Foundation

struct ModuleJSONDecoder: Codable {
    var id: String?
    var name: String?
    var description: String?
    var downloadUrl: String?
    var installedSize: Int?
    var downloadSize: Int?
    var visible: Bool?
    var selected: Bool?
    var destination: String?
    var checksum: String?

    func toModuleJSON() -> ModuleJSON {
        var result = ModuleJSON()

        result.id = id ?? ""
        result.name = name ?? ""
        result.description = description ?? ""
        result.downloadUrl = downloadUrl ?? ""
        result.installedSize = installedSize ?? 0
        result.downloadSize = downloadSize ?? 0
        result.visible = visible ?? false
        result.selected = selected ?? false
        result.destination = destination ?? nil
        result.checksum = checksum ?? nil

        return result
    }
}
