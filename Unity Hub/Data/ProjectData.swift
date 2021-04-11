//
//  ProjectData.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/28/21.
//

import Foundation

struct ProjectData {
    static let null = ProjectData(path: "")
    
    var path: String
    var name: String
    var version: UnityVersion
    var emoji: String
    var pinned: Bool
    
    var fileSize: String = ""

    var localPath: String {
        let url = URL(fileURLWithPath: path)
        let homeDir = FileManager.default.homeDirectoryForCurrentUser
        return url.relativePath.replacingOccurrences(of: homeDir.relativePath, with: "~")
    }
    
    init() {
        self.path = #"~/New Unity Project"#
        self.name = "New Unity Project"
        self.version = .null
        self.emoji = "❓"
        self.pinned = false
    }
        
    init(path: String) {
        self.path = path
        self.name = path.components(separatedBy: "/").last ?? "No Name"
        self.version = UnityVersion.null
        self.emoji = "❓"
        self.pinned = false
        
        self.version = getVersion()
    }
    
    func getVersion() -> UnityVersion {
        if FileManager.default.fileExists(atPath: path) {
            let url = URL(fileURLWithPath: path).appendingPathComponent("ProjectSettings/ProjectVersion.txt")

            do {
                var versionText = try String(contentsOf: url)
                versionText = versionText.components(separatedBy: "\n").first!
                versionText.trimPrefix("m_EditorVersion: ")
                return UnityVersion(versionText)
            } catch {
                print("Couldn't read Unity version from ProjectVersion.txt")
                print(error.localizedDescription)
            }
        }
        return UnityVersion.null
    }
    
    func equals(_ other: ProjectData) -> Bool {
        return path == other.path
    }
    
    static func isProjectPathValid(_ path: String) -> Bool {
        let fm = FileManager.default
        
        if !fm.fileExists(atPath: path) {
            return false
        }
                    
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            return items.contains("Assets") && items.contains("ProjectSettings")
        } catch {
            print(error.localizedDescription)
        }
        
        return false
    }
}

extension ProjectData: Codable {}

extension ProjectData: Identifiable {
    var id: String {
        return path
    }
}

extension ProjectData: Equatable {}

extension ProjectData: Validatable {
    mutating func validate() -> Bool {
        let isPathValid = isProjectPathValid(path)
        if isPathValid {
            version = getVersion()
        }
        return isPathValid
    }
    
    func isProjectPathValid(_ path: String) -> Bool {
        let fm = FileManager.default
        
        if !fm.fileExists(atPath: path) {
            return false
        }
                    
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            return items.contains("Assets") && items.contains("ProjectSettings")
        } catch {
            print(error.localizedDescription)
        }
        
        return false
    }
}
