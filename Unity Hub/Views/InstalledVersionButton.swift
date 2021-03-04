//
//  UnityVersionButton.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct InstalledVersionButton: View {
    @EnvironmentObject var settings: HubSettings
    var version: UnityVersion
    var hideRightSide: Bool = false
    var action: () -> Void
    @State private var modules: [(UnityModule, String)] = []
    @State private var showUninstallWarning: Bool = false
    @State private var installing: Bool = false
    
    var body: some View {
        Button(action: action) {
            HStack {
                if !installing {
                    SVGShapes.UnityCube()
                        .frame(width: 16, height: 16)
                        .padding(.leading, 12)
                        .foregroundColor(.textColor)
                } else {
                    ProgressView()
                        .frame(width: 16, height: 16)
                        .padding(.leading, 12)
                }
                Text(version.version)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.textColor)
                    .help(version.path)
                
                if version.isPrerelease() {
                    PrereleaseTag(version: version)
                        .padding(4)
                }
                Spacer()
                if !hideRightSide {
                    ForEach(modules, id: \.self.0) { item in
                        if let icon = item.0.getIcon() {
                            icon
                                .frame(width: 16, height: 16)
                                .foregroundColor(.textColor)
                                .help(item.1)
                        }
                    }
                    Menu {
                        Button("Install Additional Modules", action: {})
                        Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: version.path) })
                        Button("Uninstall Version", action: { showUninstallWarning.toggle() })
                    } label: {}
                    .menuStyle(BorderlessButtonMenuStyle())
                    .frame(width: 16, height: 48)
                    .padding(.trailing, 16)
                }
            }
            .frame(minWidth: 64, maxWidth: .infinity, minHeight: 64, maxHeight: 64)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            modules = getInstalledModules()
        }
        .alert(isPresented: $showUninstallWarning, content: {
            Alert(title: Text("Uninstall Unity \(version.version)"), message: Text("Do you really want to uninstall Unity \(version.version)?"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .destructive(Text("Uninstall"), action: uninstallVersion))
        })
    }
    
    func getInstalledModules() -> [(UnityModule, String)] {
        var unityModules: [(UnityModule, String)] = []
                
        let url = URL(fileURLWithPath: "\(version.path)/modules.json")
        do {
            let data = try Data(contentsOf: url)
            let modules: [ModuleJSON] = try! JSONDecoder().decode([ModuleJSON].self, from: data)
            
            for module in modules {
                if module.selected, let unityModule = UnityModule(rawValue: module.id) {
                    let index = unityModules.firstIndex(where: { $0.0.getPlatform() == unityModule.getPlatform() })
                    if index == nil {
                        unityModules.append((unityModule, unityModule.getDisplayName() ?? ""))
                    } else {
                        var atIndex = unityModules[index!]
                        atIndex.1.append("\n\(String(describing: unityModule.getDisplayName() ?? ""))")
                        unityModules[index!] = atIndex
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
                
        return unityModules
    }
    
    func uninstallVersion() {
        for i in 0 ..< settings.versionsInstalled.count {
            if settings.versionsInstalled[i] == version {
                DispatchQueue.global(qos: .background).async {
                    let _ = shell("rm -rf \(version.path)")
                }
                settings.versionsInstalled.remove(at: i)
                return
            }
        }
    }
}
