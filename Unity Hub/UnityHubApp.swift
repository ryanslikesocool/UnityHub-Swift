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
    
    static func getAllVersions(settings: HubSettings) {
        settings.versionsInstalled.removeAll()
        let fm = FileManager.default
        let path = settings.installLocation

        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            
            var isDir: ObjCBool = false

            for item in items {
                let path = "\(path)/\(item)"
                if fm.fileExists(atPath: path, isDirectory: &isDir) {
                    if isDir.boolValue {
                        settings.versionsInstalled.append((path, item))
                    }
                }
            }
            
            for i in 0 ..< settings.customInstallPaths.count {
                if !fm.fileExists(atPath: settings.customInstallPaths[i]) {
                    settings.customInstallPaths.remove(at: i)
                    continue
                }
                let items = try fm.contentsOfDirectory(atPath: settings.customInstallPaths[i])
                 
                if items.contains("Unity.app") {
                    if isDir.boolValue {
                        let components = settings.customInstallPaths[i].components(separatedBy: "/")
                        settings.versionsInstalled.append((settings.customInstallPaths[i], components.last!))
                    }
                } else {
                    settings.customInstallPaths.remove(at: i)
                }
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
            print(error.localizedDescription)
        }
    }
    
    static func getAllProjects(settings: HubSettings) {
        settings.projects.removeAll()
        let fm = FileManager.default
            
        for path in settings.projectPaths {
            if !fm.fileExists(atPath: path) {
                settings.projectPaths.removeAll(where: { $0 == path })
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

                settings.projects.append((path, name, version))
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
