//
//  HubSettings.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import Foundation
import SwiftUI

class HubSettings: ObservableObject {
    static let defaultInstallLocation: String = #"/Applications/Unity/Hub/Editor"#
    static let defaultHubLocation: String = #"/Applications/Unity\ Hub.app"#
    static let hubSubFolder: String = #"/Contents/MacOS/Unity\ Hub"#
    
    static var hubCommandBase: String {
        return "\(hubLocation)\(hubSubFolder) -- --headless"
    }

    static var installLocation: String {
        get { return UserDefaults.standard.string(forKey: "installLocation") ?? HubSettings.defaultInstallLocation }
        set { UserDefaults.standard.setValue(newValue, forKey: "installLocation") }
    }
    
    static var customInstallPaths: [String] {
        get { return UserDefaults.standard.stringArray(forKey: "customInstallPaths") ?? [] }
        set { UserDefaults.standard.set(newValue, forKey: "customInstallPaths") }
    }
    
    static var projectPaths: [String] {
        get { return UserDefaults.standard.stringArray(forKey: "projectPaths") ?? [] }
        set { UserDefaults.standard.set(newValue, forKey: "projectPaths") }
    }
    
    static var hubLocation: String {
        get { return UserDefaults.standard.string(forKey: "hubLocation") ?? HubSettings.defaultHubLocation }
        set { UserDefaults.standard.set(newValue, forKey: "hubLocation") }
    }
    
    static func getProjectEmoji(project: String) -> String {
        return UserDefaults.standard.string(forKey: "projectEmoji_\(project)") ?? "❓"
    }
    
    static func setProjectEmoji(emoji: String, project: String) {
        UserDefaults.standard.set(emoji, forKey: "projectEmoji_\(project)")
    }
    
    static func removeProjectEmoji(project: String) {
        UserDefaults.standard.removeObject(forKey: "projectEmoji_\(project)")
    }
    
    //path, version
    @Published var versionsInstalled: [(String, UnityVersion)] = []
    //path, name, version
    @Published var projects: [(String, String, UnityVersion)] = []
    
    var lastestVersionInstalled: UnityVersion? {
        if versionsInstalled.count == 0 {
            return nil
        }
        return versionsInstalled[0].1
    }
}
