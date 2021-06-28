//
//  ContentView.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: AppState

    @State private var selectedItem: SidebarItem? = .projects
    @State private var sidebarState: SidebarState = .normal

    enum SidebarState: CGFloat {
        case small = 96
        case between = 120
        case normal = 140
    }

    var body: some View {
        NavigationView {
            List(SidebarItem.allCases) { item in
                NavigationLink(destination: TabSelector(item: item), tag: item, selection: $selectedItem) {
                    if settings.hub.useSmallSidebar {
                        smallSidebarIcon(item: item)
                    } else {
                        normalSidebarIcon(item: item)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            // .frame(width: SidebarState.small.rawValue)
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: {
                    toggleSidebar()
                    sidebarState = .small
                }) {
                    Image(systemName: "sidebar.left")
                }
            }
        }
    }

    func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }

    /* func handleSidebarSize(_ size: CGSize) {
         print(size.width)
         if size.width == 0 {
             toggleSidebar()
         } else if size.width < SidebarState.small.rawValue {
             sidebarState = .small
         } else if size.width < SidebarState.between.rawValue {
             sidebarState = .small
         } else {
             sidebarState = .normal
         }
     } */

    func normalSidebarIcon(item: SidebarItem) -> some View {
        HStack {
            Image(systemName: item.asSymbol())
                .font(.system(size: 13, weight: .semibold))
            Text(item.asText())
                .font(.system(size: 13, weight: .semibold))
            Spacer()
            if settings.hub.showSidebarCount {
                Text(item.asSubtitleText(settings: settings))
                    .font(.system(size: 12, weight: .regular))
                    .opacity(0.75)
            }
        }
        .frame(height: 24)
    }

    func smallSidebarIcon(item: SidebarItem) -> some View {
        HStack {
            Spacer()
            Image(systemName: item.asSymbol())
                .font(.system(size: 32, weight: .semibold))
            Spacer()
        }
        .frame(height: 48)
        .padding(.vertical, 4)
    }
}
