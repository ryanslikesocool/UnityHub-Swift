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
    
    @Published var versionsInstalled: [(String, String)] = []
}
