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
        
    var hubCommandBase: String {
        return "\(hub.hubLocation)\(hubSubFolder) -- --headless"
    }
    
    @Published var hub: HubData
    
    init() {
        hub = HubData.load()
    }
    
    func save() {
        hub.save()
    }
}
