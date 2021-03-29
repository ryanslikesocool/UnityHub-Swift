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
    @State private var projectToRemove: ProjectData? = nil
    
    @State private var enableSearch: Bool = false
    @State private var searchText: String = ""

    var body: some View {
        if enableSearch {
            SearchBar(text: $searchText)
        }
        List(settings.hub.projects.filter { searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }) { project in
            let dataBinding = Binding(
                get: { return project },
                set: { settings.hub.setProject($0) }
            )
            
            VStack {
                ProjectButton(projectData: dataBinding, updateList: $updateList, deleteAction: prepareForDeletion)

                if project.path != (settings.hub.projects.last ?? ProjectData.null).path {
                    Divider()
                }
            }
        }
        .navigationTitle("Projects")
        .onChange(of: settings.hub.usePins) { _ in
            updateList.toggle()
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: toggleSearch) {
                    Image(systemName: "magnifyingglass")
                }
            }
            ToolbarItem(placement: .automatic) {
                Button(action: locateProject) {
                    Image(systemName: "folder.badge.plus")
                }
            }
            ToolbarItem(placement: .automatic) {
                Button(action: createProject) {
                    Image(systemName: "doc.badge.plus")
                }
            }
        }
        .alert(isPresented: $showRemovalSheet) { removalAlert() }
    }
    
    func removalAlert() -> Alert {
        return Alert(
            title: Text("Remove Project"),
            message: Text("Are you sure you want to remove the project \"\(projectToRemove!.name)\" from the list?\nYour project files will remain on your hard drive and will not be deleted."),
            primaryButton: .cancel(Text("Cancel")),
            secondaryButton: .destructive(Text("Remove")) { deleteItems(data: projectToRemove) }
        )
    }
    
    func toggleSearch() {
        enableSearch.toggle()
    }
    
    func locateProject() {
        NSOpenPanel.openFolder { result in
            if case let .success(path) = result {
                if !settings.hub.hasProjectAtPath(path), ProjectData.isValidProjectPath(path) {
                    settings.hub.projects.append(ProjectData(path: path))
                    settings.save()
                }
                updateList.toggle()
            }
        }
    }
    
    func prepareForDeletion(data: ProjectData) {
        projectToRemove = data
        showRemovalSheet.toggle()
    }
    
    func deleteItems(data: ProjectData?) {
        if let project = data {
            settings.hub.projects.removeAll(where: { $0.equals(project) })
            updateList.toggle()
        }
        projectToRemove = nil
    }
    
    func createProject() {}
}
