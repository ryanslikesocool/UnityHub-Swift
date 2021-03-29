//
//  HubData.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/28/21.
//

import Foundation

struct HubData {
    static let fileName: String = "HubData.json"
    static var fileLocation: URL { return FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent(fileName, isDirectory: false) }
    
    var uuid: String
    
    var hubLocation: String
    var installLocation: String
    var projectLocation: String
    
    var customInstallLocations: [String]
    
    var useEmoji: Bool
    var usePins: Bool
    var alwaysShowLocation: Bool
    var showFileSizes: Bool
    var showSidebarCount: Bool

    var starredVersion: UnityVersion
    
    var projects: [ProjectData]
    var versions: [UnityVersion]
    
    init() {
        self = .init(uuid: UUID().uuidString, projects: [])
    }
    
    init(uuid: String, projects: [ProjectData]) {
        self.uuid = uuid

        self.hubLocation = #"/Applications/Unity\ Hub.app"#
        self.installLocation = #"/Applications/Unity/Hub/Editor"#
        self.projectLocation = #"~"#
        
        self.customInstallLocations = []
        
        self.useEmoji = true
        self.usePins = true
        self.alwaysShowLocation = false
        self.showFileSizes = false
        self.showSidebarCount = true

        self.starredVersion = .null

        self.projects = projects
        self.versions = []
        
        save()
    }
    
    func save() {
        do {
            try asData()?.write(to: HubData.fileLocation)
        } catch {
            print("Couldn't save hub data\n\(error.localizedDescription)")
        }
    }
    
    static func load() -> HubData {
        do {
            let data = try Data(contentsOf: fileLocation)
            return HubData(data: data)
        } catch {
            print(error.localizedDescription)
            return HubData()
        }
    }
}

extension HubData: Codable {
    init(string: String) {
        let data = string.data(using: .utf8)!
        self = .init(data: data)
    }
    
    init(data: Data) {
        self = .init(decoder: HubDataDecoder(data: data))
        save()
    }
    
    init(decoder: HubDataDecoder) {
        self = decoder.toHubData()
    }
    
    func asData() -> Data? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(self)
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}

extension HubData: Identifiable {
    var id: String {
        return uuid
    }
}

// MARK: - Versions

extension HubData {
    var lastestVersionInstalled: UnityVersion? {
        if versions.count == 0 {
            return nil
        }
        return versions[0]
    }
    
    // TO DO: don't regenrate all
    // instead, verify each one, remove where needed
    // check other locations for new versions
    mutating func getAllVersions() {
        versions.removeAll()
        let fm = FileManager.default
        let path = installLocation

        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            
            var isDir: ObjCBool = false

            for item in items {
                let path = "\(path)/\(item)"
                if fm.fileExists(atPath: path, isDirectory: &isDir) {
                    if isDir.boolValue, UnityVersion.validateEditor(path: path) {
                        versions.append(UnityVersion(item, path: path))
                    }
                }
            }
            
            for i in 0 ..< customInstallLocations.count {
                if !fm.fileExists(atPath: customInstallLocations[i]) {
                    customInstallLocations.remove(at: i)
                    continue
                }
                let items = try fm.contentsOfDirectory(atPath: customInstallLocations[i])
                 
                if items.contains("Unity.app") {
                    if isDir.boolValue, UnityVersion.validateEditor(path: customInstallLocations[i]) {
                        let components = customInstallLocations[i].components(separatedBy: "/")
                        versions.append(UnityVersion(components.last!, path: customInstallLocations[i]))
                    }
                } else {
                    customInstallLocations.remove(at: i)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        versions.sort {
            switch $0.compare(other: $1) {
            case 1: return true
            case -1: return false
            default: return false
            }
        }
    }
}

// MARK: - Projects

extension HubData {
    func hasProjectAtPath(_ path: String) -> Bool {
        for project in projects {
            if project.path == path {
                return true
            }
        }
        return false
    }
    
    mutating func sortProjects() {
        projects.sort {
            if $0.pinned == $1.pinned || !usePins {
                return $0.name < $1.name
            }
            return $0.pinned && !$1.pinned
        }
    }
    
    mutating func setProject(_ project: ProjectData) {
        let index = projects.firstIndex(where: { $0.path == project.path })
        if let index = index {
            projects[index] = project
        }
        save()
    }
}
