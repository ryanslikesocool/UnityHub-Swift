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
    @State private var showRemovalSheet: Bool = false
    @State private var projectToRemove: IndexSet?

    var body: some View {
        List {
            ForEach(settings.projects) { project in
                VStack {
                    ProjectButton(metadata: project, updateList: $updateList)

                    if project.path != (settings.projects.last ?? ProjectMetadata.null).path {
                        ListDividerView()
                    }
                }
            }
            .onDelete(perform: {
                projectToRemove = $0
                showRemovalSheet.toggle()
            })
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
        .alert(isPresented: $showRemovalSheet) {
            Alert(
                title: Text("Remove Project"),
                message: Text("Are you sure you want to remove the project \"\(settings.projects[projectToRemove!.first!].name)\" from the list?\nYour project files will remain on your hard drive and will not be deleted."),
                primaryButton: .cancel(Text("Cancel")),
                secondaryButton: .destructive(Text("Remove")) { deleteItems(at: projectToRemove!) }
            )
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
    
    func deleteItems(at offsets: IndexSet) {
        settings.projects.remove(atOffsets: offsets)
        HubSettings.projectPaths.remove(atOffsets: offsets)
        updateList.toggle()
    }
    
    func createProject() {

    }
}
