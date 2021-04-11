//
//  HubSettings.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import Foundation
import SwiftUI

class HubSettings: ObservableObject {
    let hubSubFolder: String = #"/Contents/MacOS/Unity\ Hub"#
    var hubCommandBase: String { return "\(hub.hubLocation)\(hubSubFolder) -- --headless" }
    
    @Published var hub: HubData
    @Published var availableVersions: [UnityVersion] = []

    init() {
        hub = HubData.load()
        UserDefaults.standard.set(1, forKey: "NSConstraintBasedLayoutVisualizeMutuallyExclusiveConstraints")
    }
    
    func wrap() {
        hub.wrap()
    }
}

extension HubSettings {
    var lastestVersionInstalled: UnityVersion? {
        if hub.versions.count == 0 {
            return nil
        }
        return hub.versions.first
    }
    
    // TO DO: don't regenrate all
    // instead, verify each one, remove where needed
    // check other locations for new versions
    func getAllVersions() {
        hub.versions.removeAll()
        let fm = FileManager.default
        let path = hub.installLocation

        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            
            var isDir: ObjCBool = false

            for item in items {
                let path = "\(path)/\(item)"
                if fm.fileExists(atPath: path, isDirectory: &isDir) {
                    if isDir.boolValue, UnityVersion.isEditorValid(path: path) {
                        hub.versions.append(UnityVersion(item, path: path))
                    }
                }
            }
            
            for location in hub.customInstallLocations {
                if !fm.fileExists(atPath: location) {
                    hub.customInstallLocations.removeElement(location)
                    continue
                }
                let items = try fm.contentsOfDirectory(atPath: location)
                 
                if items.contains("Unity.app") {
                    if isDir.boolValue, UnityVersion.isEditorValid(path: location) {
                        let components = location.components(separatedBy: "/")
                        hub.versions.append(UnityVersion(components.last!, path: location))
                    }
                } else {
                    hub.customInstallLocations.removeElement(location)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        hub.versions.sort {
            switch $0.compare(other: $1) {
            case 1: return true
            case -1: return false
            default: return false
            }
        }
    }

    func setDefaultVersion(_ version: UnityVersion) {
        if version == hub.defaultVersion {
            hub.defaultVersion = .null
        } else {
            hub.defaultVersion = version
        }
        wrap()
    }
    
    func isDefaultVersion(_ version: UnityVersion) -> Bool {
        return version.version == hub.defaultVersion.version
    }
    
    func setModule(_ version: UnityVersion, _ module: ModuleJSON) {
        var version = version
        version.modules.setElement(module, where: { $0.id == module.id })
        hub.versions.setElement(version, where: { $0.version == version.version })
        wrap()
    }
    
    func getAvailableVersions() {
        DispatchQueue.global(qos: .background).async {
            var versions: [UnityVersion] = []

            let command = "\(self.hubCommandBase) e -r"
            let result = shell(command)
            let results = result.components(separatedBy: "\n")
            
            for result in results {
                let version = result.components(separatedBy: " ").first
                if let version = version, version != "", !self.hub.versions.contains(where: { $0.version == version }) {
                    versions.append(UnityVersion(version))
                }
            }

            DispatchQueue.main.async {
                self.availableVersions = versions
            }
        }
    }
}

extension HubSettings {    
    func hasProjectAtPath(_ path: String) -> Bool {
        for project in hub.projects {
            if project.path == path {
                return true
            }
        }
        return false
    }
    
    func getProjectAtPath(_ path: String) -> ProjectData? {
        return hub.projects.first(where: { $0.path == path })
    }
    
    func sortProjects() {
        hub.projects.sort {
            if $0.pinned == $1.pinned || !hub.usePins {
                return $0.name < $1.name
            }
            return $0.pinned && !$1.pinned
        }
    }
    
    func setProject(_ project: ProjectData) {
        hub.projects.setElement(project, where: { $0.path == project.path })
        wrap()
    }
    
    func getRealVersion(_ version: UnityVersion) -> UnityVersion? {
        return hub.versions.first(where: { version.version == $0.version })
    }
    
    func setVersionDefaultLocation() {
        let command = "\(hubCommandBase) ip -s \(hub.installLocation)"
        DispatchQueue.global(qos: .background).async {
            let result = shell(command)
            DispatchQueue.main.async {
                print(result)
            }
        }
    }
}
