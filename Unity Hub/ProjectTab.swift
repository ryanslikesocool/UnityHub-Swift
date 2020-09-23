//
//  ProjectTab.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct ProjectTab: View {
    @EnvironmentObject var settings: HubSettings

    var body: some View {
        List {
            ForEach(settings.projects, id: \.self.1) { project in
                ProjectButton(path: project.0, project: project.1, version: project.2)
            }
        }
        .navigationTitle("Projects")
        .onAppear(perform: getAllProjects)
        .onDisappear(perform: { settings.projects.removeAll() })
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
            do {
                let items = try fm.contentsOfDirectory(atPath: path)
                if !items.contains("Assets") || !items.contains("ProjectSettings") {
                    continue
                }
                
                let name = path.components(separatedBy: "/").last!
                var version: String = ""
                
                let versionPath = "file://\(path)/ProjectSettings/ProjectVersion.txt"

                if let url = URL(string: versionPath) {
                    let versionText = try String(contentsOf: url)
                    version = versionText.components(separatedBy: "\n").first!
                    version.trimPrefix("m_EditorVersion: ")
                }
                
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
                
                settings.projects.removeAll()
                getAllProjects()
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
