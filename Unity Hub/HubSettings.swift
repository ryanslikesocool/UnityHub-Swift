//
//  HubSettings.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import Foundation
import SwiftUI

class HubSettings: ObservableObject {
    static let defaultInstallLocation: String = "/Applications/Unity/Hub/Editor"
    
    var installLocation: String {
        get { return UserDefaults.standard.string(forKey: "installLocation") ?? HubSettings.defaultInstallLocation }
        set { UserDefaults.standard.setValue(newValue, forKey: "installLocation") }
    }
    
    var customInstallPaths: [String] {
        get { return UserDefaults.standard.object(forKey: "customInstallPaths") as? [String] ?? [] }
        set { UserDefaults.standard.set(newValue, forKey: "customInstallPaths") }
    }
    
    var projectPaths: [String] {
        get { return UserDefaults.standard.object(forKey: "projectPaths") as? [String] ?? [] }
        set { UserDefaults.standard.set(newValue, forKey: "projectPaths") }
    }
    
    func getProjectEmoji(project: String) -> String {
        return UserDefaults.standard.string(forKey: "projectEmoji_\(project)") ?? "❓"
    }
    
    func setProjectEmoji(emoji: String, project: String) {
        UserDefaults.standard.set(emoji, forKey: "projectEmoji_\(project)")
    }
    
    func removeProjectEmoji(project: String) {
        UserDefaults.standard.removeObject(forKey: "projectEmoji_\(project)")
    }
    
    @Published var versionsInstalled: [(String, UnityVersion)] = []
    @Published var projects: [(String, String, String)] = []
    
    var lastestVersionInstalled: UnityVersion? {
        if versionsInstalled.count == 0 {
            return nil
        }
        return versionsInstalled[0].1
    }
}
