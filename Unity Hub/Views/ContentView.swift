//
//  ContentView.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedItem: SidebarItem? = .projects

    var body: some View {
        NavigationView {
            List(SidebarItem.allCases) { item in
                switch item {
                case .projects, .installs:
                    SidebarItemView(enabled: true, item: item, selectedItem: $selectedItem)
                case .learn, .community:
                    SidebarItemView(enabled: false, item: item, selectedItem: $selectedItem)
                }
            }
            .listStyle(SidebarListStyle())
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: toggleSidebar, label: {
                        Image(systemName: "sidebar.left")
                    })
                }
            }
        }
    }
    
    func toggleSidebar() {
            NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
