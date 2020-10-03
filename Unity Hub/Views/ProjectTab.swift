//
//  ProjectTab.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct ProjectTab: View {
    @EnvironmentObject var settings: HubSettings
    @State private var updateList: Bool = false

    var body: some View {
        List {
            ForEach(settings.projects, id: \.self.1) { project in
                ProjectButton(path: project.0, project: project.1, version: project.2, updateList: $updateList)
            }
        }
        .navigationTitle("Projects")
        .onAppear(perform: getAllProjects)
        .onChange(of: updateList) { value in
            getAllProjects()
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: locateProject) {
                    Image(systemName: "magnifyingglass")
                }
            }
            ToolbarItem(placement: .automatic) {
                Button(action: createProject) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func getAllProjects() {
        UnityHubApp.getAllProjects(settings: settings)
    }
    
    func locateProject() {
        NSOpenPanel.openFolder { result in
            if case let .success(path) = result {
                if !HubSettings.projectPaths.contains(path) {
                    HubSettings.projectPaths.append(path)
                }
                
                updateList.toggle()
            }
        }
    }
    
    func createProject() {

    }
}
