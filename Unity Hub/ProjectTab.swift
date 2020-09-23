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
        .onDisappear(perform: { settings.projects.removeAll() })
        .onChange(of: updateList) { value in
            settings.projects.removeAll()
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
        let fm = FileManager.default
            
        for path in settings.projectPaths {
            if !fm.fileExists(atPath: path) {
                settings.projectPaths.removeAll(where: { $0 == path })
                continue
            }
            
            do {
                let items = try fm.contentsOfDirectory(atPath: path)
                if !items.contains("Assets") || !items.contains("ProjectSettings") {
                    continue
                }
                
                let name = path.components(separatedBy: "/").last!
                var version: String = ""
                
                let versionPath = "\(path)/ProjectSettings/ProjectVersion.txt"

                let url = URL(fileURLWithPath: versionPath)
                let versionText = try String(contentsOf: url)
                version = versionText.components(separatedBy: "\n").first!
                version.trimPrefix("m_EditorVersion: ")

                settings.projects.append((path, name, version))
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func locateProject() {
        NSOpenPanel.openFolder { result in
            if case let .success(path) = result {
                if !settings.projectPaths.contains(path) {
                    settings.projectPaths.append(path)
                }
                
                updateList.toggle()
            }
        }
    }
    
    func createProject() {

    }
}

struct ProjectTab_Previews: PreviewProvider {
    static var previews: some View {
        ProjectTab()
    }
}
