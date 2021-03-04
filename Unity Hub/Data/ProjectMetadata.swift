//
//  ProjectMetadata.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/4/21.
//

import Foundation

struct ProjectMetadata {
    static let null: ProjectMetadata = ProjectMetadata(path: "", name: "", version: UnityVersion.null)
    static let fileName: String = ".hubS"
    
    //required data
    var path: String //path to project
    var name: String //project name
    var version: UnityVersion //project's editor version
    
    //custom data
    var emojiTag: String //the emoji tag to display in the project view
    var pinned: Bool //is the project pinned to the top of the project view
    
    init(path: String, name: String, version: UnityVersion, emojiTag: String = "", pinned: Bool = false) {
        self.path = path
        self.name = name
        self.version = version
        
        self.emojiTag = emojiTag
        self.pinned = pinned
    }
    
    init(readFrom: String) {
        let fm = FileManager.default
        
        do {
            let items = try fm.contentsOfDirectory(atPath: readFrom)
            if !items.contains(ProjectMetadata.fileName) {
                path = readFrom
                name = path.components(separatedBy: "/").last!
                
                let versionPath = "\(path)/ProjectSettings/ProjectVersion.txt"
                let url = URL(fileURLWithPath: versionPath)
                var versionText = try String(contentsOf: url)
                versionText = versionText.components(separatedBy: "\n").first!
                versionText.trimPrefix("m_EditorVersion: ")
                version = UnityVersion(versionText)
                
                emojiTag = "❓"
                pinned = false
                
                //print("Created metadata for \(name)")
                save()
            } else {
                let fileURL = URL(fileURLWithPath: readFrom).appendingPathComponent(ProjectMetadata.fileName)
                let metaText = try String(contentsOf: fileURL)
                let lines = metaText.components(separatedBy: "\n")
                
                path = lines[0]
                name = lines[1]
                version = UnityVersion(lines[2])
                
                emojiTag = lines[3]
                pinned = lines[4] == "true"
                
                //print("Loaded metadata for \(name)")
            }
        } catch {
            print(error.localizedDescription)
            
            path = readFrom
            name = path.components(separatedBy: "/").last!
            version = UnityVersion.null
            
            emojiTag = "❓"
            pinned = false
            
            //print("Created metadata for \(name)")
            save()
        }
    }
    
    func save() {
        let fileURL = URL(fileURLWithPath: path).appendingPathComponent(ProjectMetadata.fileName)
        
        do {
            try asString().write(toFile: fileURL.path, atomically: false, encoding: .utf8)
            //print("Saved metadata for \(name)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func asString() -> String {
        return """
            \(path)
            \(name)
            \(version.version)
            \(emojiTag)
            \(pinned ? "true" : "false")
            """
    }
}

extension ProjectMetadata: Identifiable {
    var id: String {
        return path
    }
}
