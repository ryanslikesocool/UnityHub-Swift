//
//  ProjectTab.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct ProjectPanel: View {
    @EnvironmentObject var settings: HubSettings
    @State private var updateList: Bool = false

    var body: some View {
        List(settings.projects, id: \.self.1) { project in
            VStack {
                ProjectButton(path: project.0, project: project.1, version: project.2, updateList: $updateList)
                
                if project != settings.projects.last ?? ("", "", UnityVersion.null) {
                    ListDividerView()
                }
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
                    Image(systemName: "folder")
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
        HubSettings.getAllProjects(settings: settings)
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
