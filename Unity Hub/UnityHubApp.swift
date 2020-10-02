//
//  AppDelegate.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

@main
struct UnityHubApp: App {
    var settings: HubSettings = HubSettings()
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 750, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
                .environmentObject(settings)
                .onAppear(perform: { UnityHubApp.getAllVersions(settings: settings) })
        }
        .windowStyle(TitleBarWindowStyle())
        .windowToolbarStyle(UnifiedWindowToolbarStyle())
        
        Settings {
            SettingsView()
                .frame(width: 320, height: 384)
                .environmentObject(settings)
                .navigationTitle("Settings")
        }
    }
    
    //TO DO: don't recalculate all
    static func getAllVersions(settings: HubSettings) {
        settings.versionsInstalled.removeAll()
        let fm = FileManager.default
        let path = HubSettings.installLocation

        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            
            var isDir: ObjCBool = false

            for item in items {
                let path = "\(path)/\(item)"
                if fm.fileExists(atPath: path, isDirectory: &isDir) {
                    if isDir.boolValue && validateEditor(path: path) {
                        settings.versionsInstalled.append((path, UnityVersion(item)))
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
                    if isDir.boolValue && validateEditor(path: HubSettings.customInstallPaths[i]) {
                        let components = HubSettings.customInstallPaths[i].components(separatedBy: "/")
                        settings.versionsInstalled.append((HubSettings.customInstallPaths[i], UnityVersion(components.last!)))
                    }
                } else {
                    HubSettings.customInstallPaths.remove(at: i)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        settings.versionsInstalled.sort {
            switch $0.1.compare(other: $1.1) {
            case 1: return true
            case -1: return false
            default: return false
            }
        }
    }
    
    static func getAllProjects(settings: HubSettings) {
        settings.projects.removeAll()
        let fm = FileManager.default
            
        for path in HubSettings.projectPaths {
            if !fm.fileExists(atPath: path) {
                HubSettings.projectPaths.removeAll(where: { $0 == path })
                let name = path.components(separatedBy: "/").last!
                HubSettings.removeProjectEmoji(project: name)
                continue
            }
            
            do {
                let items = try fm.contentsOfDirectory(atPath: path)
                if !items.contains("Assets") || !items.contains("ProjectSettings") {
                    continue
                }
                
                let name = path.components(separatedBy: "/").last!
                var version: String = ""
                
                let versionPath = "\(path)/ProjectSettings/ProjectVersion.txt"

                let url = URL(fileURLWithPath: versionPath)
                let versionText = try String(contentsOf: url)
                version = versionText.components(separatedBy: "\n").first!
                version.trimPrefix("m_EditorVersion: ")
                
                settings.projects.append((path, name, UnityVersion(version)))
            } catch {
                print(error.localizedDescription)
            }
        }
        
        settings.projects.sort(by: { $0.1 < $1.1 })
    }
    
    static func validateEditor(path: String/*, version: UnityVersion*/) -> Bool {
        /*if version.installing {
            return true
        }*/
        do {
            var format = PropertyListSerialization.PropertyListFormat.xml
            let plistData = try Data(contentsOf: URL(fileURLWithPath: "\(path)/Unity.app/Contents/Info.plist"))
            if let plistDictionary = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: &format) as? [String : AnyObject] {
                if let bundleID = plistDictionary["CFBundleIdentifier"] as? String {
                    if !bundleID.contains("com.unity3d.UnityEditor") {
                        print("Invalid bundle identifier")
                        return false
                    }
                } else {
                    print("No bundle identifier")
                    return false
                }
            } else {
                print("No valid plist")
                return false
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return true
    }
}
