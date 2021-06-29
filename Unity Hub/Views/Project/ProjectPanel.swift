//
//  ProjectTab.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct ProjectPanel: View {
    @EnvironmentObject var settings: AppState
    
    @State private var updateList: Bool = false
    @State private var showRemovalSheet: Bool = false
    @State private var projectToRemove: ProjectData? = nil
    
    @State private var searchText: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            let sizeBinding = Binding(get: { geometry.size.width }, set: { _ in })

            List {
                ForEach(settings.hub.projects.filter { searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }) { project in
                    let dataBinding = Binding(
                        get: { project },
                        set: { settings.setProject($0) }
                    )
                
                    ProjectButton(viewWidth: sizeBinding, project: dataBinding, updateList: $updateList, deleteAction: prepareForDeletion)
                        .padding(.vertical, -4)
                    if project != settings.hub.projects.last ?? ProjectData.null {
                        Divider()
                    }
                }
            }
            .navigationTitle("Projects")
            .onChange(of: settings.hub.usePins || settings.hub.showFileSize) { _ in
                updateList.toggle()
            }
			.animation(.interactiveSpring())
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    SearchBar(text: $searchText)
                        .frame(width: 200)
                        .padding(.trailing, 8)
                }
                ToolbarItem(placement: .automatic) {
                    Button(action: locateProject) {
                        Image(systemName: "folder")
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Button(action: createProject) {
                        Image(systemName: "doc")
                    }
                }
            }
            .alert(isPresented: $showRemovalSheet) { removalAlert() }
            .onAppear {
                settings.sortProjects()
            }
        }
    }
    
    func removalAlert() -> Alert {
        return Alert(
            title: Text("Remove Project"),
            message: Text("Are you sure you want to remove the project \"\(projectToRemove!.name)\" from the list?\nYour project files will remain on your hard drive and will not be deleted."),
            primaryButton: .cancel(Text("Cancel")),
            secondaryButton: .destructive(Text("Remove")) { deleteItems(data: projectToRemove) }
        )
    }
    
    func locateProject() {
        NSOpenPanel.openFolder { result in
            if case let .success(path) = result {
                if settings.getProjectAtPath(path) == nil, ProjectData.isProjectPathValid(path) {
                    settings.hub.projects.append(ProjectData(path: path))
                    settings.wrap()
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
