//
//  ProjectButton.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import AppKit
import Cocoa
import Dispatch
import Foundation
import SwiftUI

struct ProjectButton: View {
    @EnvironmentObject var settings: HubSettings
    
    @Binding var viewWidth: CGFloat

    @Binding var project: ProjectData
    @Binding var updateList: Bool
        
    var deleteAction: (ProjectData) -> Void
    
    @State private var showVersionWarning: Bool = false
    @State private var showWarning: Bool = false

    @State private var showSheet: Bool = false
    @State private var showPopover: Bool = false
    @State private var activeSheet: ActiveSheet?
        
    var sizeEmpty: Bool { return project.fileSize == "" }
    var sizeLoading: Bool { return project.fileSize == "." }

    private var leadingSwipeActions: [Slot] {
        return settings.hub.usePins ? [Slot(
            image: { Image(systemName: .pinIcon).frame(width: .swipeActionLargeIconSize, height: .swipeActionLargeIconSize).embedInAnyView() },
            title: { EmptyView().embedInAnyView() },
            action: togglePin,
            style: .init(background: .orange, slotHeight: .listItemHeight)
        )] : []
    }

    private var trailingSwipeActions: [Slot] {
        return [Slot(
            image: { Image(systemName: .trashIcon).frame(width: .swipeActionLargeIconSize, height: .swipeActionLargeIconSize).embedInAnyView() },
            title: { EmptyView().embedInAnyView() },
            action: { deleteAction(project) },
            style: .init(background: .red, slotHeight: .listItemHeight)
        )]
    }
        
    enum ActiveSheet: Identifiable {
        case advancedSettings
        
        var id: Int {
            hashValue
        }
    }
    
    var body: some View {
        let versionBinding = Binding(
            get: { self.project.version },
            set: { self.project.version = $0 }
        )
        let emojiBinding = Binding(
            get: { self.project.emoji },
            set: { self.project.emoji = $0 }
        )
        
        return HStack {
            emojiArea(emojiBinding: emojiBinding)
                .popover(isPresented: $showPopover) { EmojiPicker(action: { emojiBinding.wrappedValue = $0 }) }
            Button(action: openProject) {
                titleArea()
            }
            .buttonStyle(PlainButtonStyle())
            if settings.hub.usePins && project.pinned {
                Image(systemName: .pinIcon)
                    .font(.system(size: 13, weight: .semibold))
                    .rotationEffect(Angle(degrees: 45))
            }
            Spacer()
            if settings.hub.showFileSize {
                LoadingText(text: $project.fileSize)
                    .padding(.trailing, 8)
            }
            if showWarning {
                Image(systemName: .warningIcon)
                    .help("The Editor version associated with this project is not currently available on this machine.  Go to Installs to download a matching version")
            }
            Menu {
                ForEach(settings.hub.versions) { version in
                    Button("Unity \(version.version)") {
                        project.version = version
                    }
                }
            } label: { Text("Unity \(versionBinding.wrappedValue.version)") }
                .frame(width: 128)
            Menu {
                dropDownMenu()
            } label: {}
                .menuStyle(BorderlessButtonMenuStyle())
                .frame(width: 16, height: 48)
                .padding(.trailing, 40)
        }
        .frame(width: viewWidth, height: .listItemHeight)
        .contentShape(Rectangle())
        .contextMenu { dropDownMenu() }
        .onAppear {
            if settings.hub.showFileSize, sizeEmpty || sizeLoading {
                getProjectSize()
            }
            if !settings.hub.versions.contains(where: { $0.version == project.version.version }) {
                showWarning = true
            }
        }
        .onDisappear {
            if sizeLoading {
                project.fileSize = ""
            }
        }
        .onChange(of: settings.hub.showFileSize) { toggle in
            if toggle, sizeEmpty || sizeLoading {
                getProjectSize()
            }
        }
        .sheet(item: $activeSheet) { sheetView(item: $0, emoji: emojiBinding, version: versionBinding) }
        .alert(isPresented: $showVersionWarning) {
            Alert(title: Text("Missing Unity Version"), message: Text("The Unity version last used to open this project (\(project.version.version)) is missing.  Please reinstall it or redownload the version."), dismissButton: .default(Text("Ok")))
        }
        // .onSwipe(leading: leadingSwipeActions, trailing: trailingSwipeActions)
        /* .trackingMouse { location, delta in
             print(delta)
         } */
    }
    
    func emojiArea(emojiBinding: Binding<String>) -> some View {
        Group {
            if settings.hub.useEmoji {
                Button(action: { showPopover.toggle() }) {
                    Text(emojiBinding.wrappedValue)
                        .font(.system(size: 32))
                        .padding(.leading, 16)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }
    
    func titleArea() -> some View {
        VStack(alignment: .leading) {
            if !settings.hub.showLocation {
                Text(project.name)
                    .font(.system(size: 12, weight: .semibold))
                    .help(project.localPath)
            } else {
                Text(project.name)
                    .font(.system(size: 12, weight: .semibold))
                Text(project.localPath)
                    .font(.system(size: 10, weight: .regular))
                    .opacity(0.5)
                    .help(project.path)
            }
        }
    }
    
    func dropDownMenu() -> some View {
        Group {
            Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: project.path) })
            if settings.hub.useEmoji {
                Divider()
                Button("Select Emoji", action: { showPopover.toggle() })
                if !settings.hub.usePins {
                    Divider()
                }
            }
            if settings.hub.usePins {
                if !settings.hub.useEmoji {
                    Divider()
                }
                Button("Toggle Pin", action: togglePin)
                Divider()
            }
            Button("Remove Project", action: { deleteAction(project) })
        }
    }
    
    func sheetView(item: ActiveSheet, emoji: Binding<String>, version: Binding<UnityVersion>) -> some View {
        Group {
            switch item {
            case .advancedSettings: AdvancedProjectSettingsSheet()
            }
        }
    }
    
    func getShellCommand() -> String? {
        showWarning = false
        showVersionWarning = false
        
        if let version = settings.getRealVersion(project.version), settings.hub.versions.contains(project.version) {
            let result = "\(version.path)/Unity.app/Contents/MacOS/Unity -projectPath \"\(project.path)\""
            return result
        }
        
        showWarning = true
        showVersionWarning = true
        return nil
    }
    
    func openProject() {
        if let shellCommand = getShellCommand(), !showWarning {
            DispatchQueue.global(qos: .background).async {
                _ = shell(shellCommand)
            }
        } else {
            showVersionWarning = true
        }
        NSApp.hide(nil)
    }
        
    func openAdvancedSettings() {
        activeSheet = .advancedSettings
        showSheet.toggle()
    }
    
    func togglePin() {
        project.pinned.toggle()
        settings.wrap()
        settings.sortProjects()
        updateList.toggle()
    }
    
    func getProjectSize() {
        project.fileSize = "."
        DispatchQueue.global(qos: .background).async {
            let url = URL(fileURLWithPath: project.path)
            var size = ""
            do {
                size = try url.sizeOnDisk() ?? ""
            } catch {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                project.fileSize = size
            }
        }
    }
    
    func moveFile(newName: String) {
        var components = project.path.components(separatedBy: "/")
        _ = components.removeLast()
        var newPath = components.joined(separator: "/")
        newPath.append("/\(newName)")
        
        do {
            try FileManager.default.moveItem(atPath: project.path, toPath: newPath)
        } catch {
            print(error.localizedDescription)
        }
    }
}
