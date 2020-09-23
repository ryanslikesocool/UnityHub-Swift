//
//  ModuleJSON.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import Foundation

struct ModuleJSON: Codable {
    let id: String
    let name: String
    let description: String
    let downloadUrl: String
    let installedSize: Int
    let downloadSize: Int
    let visible: Bool
    let selected: Bool
    let destination: String?
    let checksum: String?
}
