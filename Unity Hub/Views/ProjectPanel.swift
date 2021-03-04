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

    @State private var projectToRemove: ProjectMetadata?

    var body: some View {
        let useEmoji = Binding(
            get: { HubSettings.useEmoji },
            set: { HubSettings.useEmoji = $0 }
        )
        let usePins = Binding(
            get: { HubSettings.usePins },
            set: { HubSettings.usePins = $0 }
        )
        let alwaysShowLocation = Binding(
            get: { HubSettings.alwaysShowLocation },
            set: { HubSettings.alwaysShowLocation = $0 }
        )
        
        List {
            ForEach(settings.projects) { project in
                VStack {
                    ProjectButton(metadata: project, updateList: $updateList, useEmoji: useEmoji, usePins: usePins, alwaysShowLocation: alwaysShowLocation, deleteAction: prepareForDeletion)

                    if project.path != (settings.projects.last ?? ProjectMetadata.null).path {
                        ListDividerView()
                    }
                }
            }
            .onDelete(perform: prepareForDeletion)
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
                message: Text("Are you sure you want to remove the project \"\(projectToRemove!.name)\" from the list?\nYour project files will remain on your hard drive and will not be deleted."),
                primaryButton: .cancel(Text("Cancel")),
                secondaryButton: .destructive(Text("Remove")) { deleteItems(metadata: projectToRemove) }
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
    
    func prepareForDeletion(offsets: IndexSet) {
        prepareForDeletion(metadata: settings.projects[offsets.first!])
    }
    
    func prepareForDeletion(metadata: ProjectMetadata) {
        projectToRemove = metadata
        showRemovalSheet.toggle()
    }
    
    func deleteItems(metadata: ProjectMetadata?) {
        if let project = metadata {
            settings.projects.removeAll(where: { $0.compare(other: project) })
            HubSettings.projectPaths.removeAll(where: { $0 == project.path })
            updateList.toggle()
        }
        projectToRemove = nil
    }
    
    func createProject() {

    }
}
