//
//  HubDataDecoder.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/29/21.
//

import Foundation

struct HubDataDecoder: Codable {
    var uuid: String?
    
    var hubLocation: String?
    var installLocation: String?
    var projectLocation: String?
    
    var customInstallLocations: [String]?
    
    var useEmoji: Bool?
    var usePins: Bool?
    var alwaysShowLocation: Bool?
    var showFileSizes: Bool?
    var showSidebarCount: Bool?

    var starredVersion: UnityVersionDecoder?
    
    var projects: [ProjectDataDecoder]?
    var versions: [UnityVersionDecoder]?
        
    init(data: Data) {
        do {
            self = try JSONDecoder().decode(HubDataDecoder.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func toHubData() -> HubData {
        var result = HubData()
        
        result.uuid = uuid ?? UUID().uuidString
        
        result.hubLocation = hubLocation ?? #"/Applications/Unity\ Hub.app"#
        result.installLocation = installLocation ?? #"/Applications/Unity/Hub/Editor"#
        result.projectLocation = projectLocation ?? #"~"#

        result.customInstallLocations = customInstallLocations ?? []

        result.useEmoji = useEmoji ?? true
        result.usePins = usePins ?? true
        result.alwaysShowLocation = alwaysShowLocation ?? false
        result.showFileSizes = showFileSizes ?? false
        result.showSidebarCount = showSidebarCount ?? true
        
        result.starredVersion = starredVersion?.toUnityVersion() ?? .null
        
        result.projects = projects?.map { $0.toProjectData() } ?? []
        result.versions = versions?.map { $0.toUnityVersion() } ?? []

        return result
    }
}
