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
                            Text(item.rawValue.1)
                            Spacer()
                        }
                        .font(.system(size: 12, weight: .semibold))
                        .frame(width: 192, height: 28)
                    }
                case .learn, .community:
                    HStack {
                        Image(systemName: item.rawValue.2)
                        Text(item.rawValue.1)
                        Spacer()
                    }
                    .font(.system(size: 12, weight: .semibold))
                    .frame(width: 192, height: 28)
                    .foregroundColor(.gray)
                }
            }
            .frame(width: 160)
            .listStyle(SidebarListStyle())
            .navigationTitle("Unity Hub")
        }
    }
}
