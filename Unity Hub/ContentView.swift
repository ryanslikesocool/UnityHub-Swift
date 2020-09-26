//
//  ContentView.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedItem: SidebarItem? = SidebarItem.projects

    var body: some View {
        NavigationView {
            List(SidebarItem.allCases) { item in
                switch item {
                case .projects, .installs:
                    NavigationLink(destination: TabSelector(item: item), tag: item, selection: $selectedItem) {
                        HStack {
                            Image(systemName: item.rawValue.2)
                                .font(.system(size: 12, weight: .black))
                            Text(item.rawValue.1)
                                .font(.system(size: 12, weight: .semibold))
                            Spacer()
                        }
                        .frame(width: 192, height: 28)
                    }
                case .learn, .community:
                    HStack {
                        Image(systemName: item.rawValue.2)
                            .font(.system(size: 12, weight: .black))
                        Text(item.rawValue.1)
                            .font(.system(size: 12, weight: .semibold))
                        Spacer()
                    }
                    .frame(width: 192, height: 28)
                    .foregroundColor(.gray)
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
