//
//  HubSettings.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import Foundation
import SwiftUI

class HubSettings: ObservableObject {
    static var customInstallPaths: [String] {
        get { return UserDefaults.standard.stringArray(forKey: "customInstallPaths") ?? [] }
        set { UserDefaults.standard.set(newValue, forKey: "customInstallPaths") }
    }
    static var projectPaths: [String] {
        get { return UserDefaults.standard.stringArray(forKey: "projectPaths") ?? [] }
        set { UserDefaults.standard.set(newValue, forKey: "projectPaths") }
    }
    
    @Published var versionsInstalled: [UnityVersion] = []
    @Published var projects: [ProjectMetadata] = []
    
    var hubLocation: String {
        willSet {
            objectWillChange.send()
            UserDefaults.standard.set(newValue, forKey: "hubLocation")
        }
    }
    var installLocation: String {
        willSet {
            objectWillChange.send()
            UserDefaults.standard.set(newValue, forKey: "installLocation")
        }
    }
    var projectLocation: String {
        willSet {
            objectWillChange.send()
            UserDefaults.standard.set(newValue, forKey: "projectLocation")
        }
    }
    
    var useEmoji: Bool {
        willSet {
            objectWillChange.send()
            UserDefaults.standard.set(newValue, forKey: "useEmoji")
        }
    }
    var usePins: Bool {
        willSet {
            objectWillChange.send()
            UserDefaults.standard.set(newValue, forKey: "usePins")
        }
    }
    var alwaysShowLocation: Bool {
        willSet {
            objectWillChange.send()
            UserDefaults.standard.set(newValue, forKey: "alwaysShowLocation")
        }
    }
    var showSidebarCount: Bool {
        willSet {
            objectWillChange.send()
            UserDefaults.standard.set(newValue, forKey: "showSidebarCount")
        }
    }
    
    let hubSubFolder: String = #"/Contents/MacOS/Unity\ Hub"#

    var hubCommandBase: String {
        return "\(hubLocation)\(hubSubFolder) -- --headless"
    }
    
    init() {
        hubLocation = UserDefaults.standard.string(forKey: "hubLocation") ?? #"/Applications/Unity\ Hub.app"#
        installLocation = UserDefaults.standard.string(forKey: "installLocation") ?? #"/Applications/Unity/Hub/Editor"#
        projectLocation = UserDefaults.standard.string(forKey: "projectLocation") ?? #"~"#
        
        useEmoji = UserDefaults.hasKey("useEmoji") ? UserDefaults.standard.bool(forKey: "useEmoji") : true
        usePins = UserDefaults.hasKey("usePins") ? UserDefaults.standard.bool(forKey: "usePins") : true
        alwaysShowLocation = UserDefaults.hasKey("alwaysShowLocation") ? UserDefaults.standard.bool(forKey: "alwaysShowLocation") : false
        showSidebarCount = UserDefaults.hasKey("showSidebarCount") ? UserDefaults.standard.bool(forKey: "showSidebarCount") : true
    }
    
    var lastestVersionInstalled: UnityVersion? {
        if versionsInstalled.count == 0 {
            return nil
        }
        return versionsInstalled[0]
    }
    
    //TO DO: don't recalculate all
    func getAllVersions() {
        versionsInstalled.removeAll()
        let fm = FileManager.default
        let path = installLocation

        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            
            var isDir: ObjCBool = false

            for item in items {
                let path = "\(path)/\(item)"
                if fm.fileExists(atPath: path, isDirectory: &isDir) {
                    if isDir.boolValue && UnityVersion.validateEditor(path: path) {
                        versionsInstalled.append(UnityVersion(item, path: path))
                    }
                }
            }
            
            for i in 0 ..< HubSettings.customInstallPaths.count {
                if !fm.fileExists(atPath: HubSettings.customInstallPaths[i]) {
                    HubSettings.customInstallPaths.remove(at: i)
                    continue
                }
                let items = try fm.contentsOfDirectory(atPath: HubSettings.customInstallPaths[i])
                 
                if items.contains("Unity.app") {
                    if isDir.boolValue && UnityVersion.validateEditor(path: HubSettings.customInstallPaths[i]) {
                        let components = HubSettings.customInstallPaths[i].components(separatedBy: "/")
                        versionsInstalled.append(UnityVersion(components.last!, path: HubSettings.customInstallPaths[i]))
                    }
                } else {
                    HubSettings.customInstallPaths.remove(at: i)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        versionsInstalled.sort {
            switch $0.compare(other: $1) {
            case 1: return true
            case -1: return false
            default: return false
            }
        }
    }
    
    func getAllProjects() {
        projects.removeAll()
        let fm = FileManager.default
            
        for path in HubSettings.projectPaths {
            if !fm.fileExists(atPath: path) {
                HubSettings.projectPaths.removeAll(where: { $0 == path })
                continue
            }
            
            do {
                let items = try fm.contentsOfDirectory(atPath: path)
                if !items.contains("Assets") || !items.contains("ProjectSettings") {
                    continue
                }
                                
                projects.append(ProjectMetadata(readFrom: path, availableVersions: versionsInstalled))
            } catch {
                print(error.localizedDescription)
            }
        }
        
        sortProjects()
    }
    
    func sortProjects() {
        projects.sort {
            if $0.pinned == $1.pinned {
                return $0.name < $1.name
            }
            return $0.pinned && !$1.pinned
        }
        
        HubSettings.projectPaths.removeAll()
        HubSettings.projectPaths.append(contentsOf: projects.map { $0.path } )
    }
}
