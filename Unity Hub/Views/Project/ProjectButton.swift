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

    @Binding var projectData: ProjectData
    @Binding var updateList: Bool
        
    var deleteAction: (ProjectData) -> Void
    
    @State private var showVersionWarning: Bool = false
    @State private var showWarning: Bool = false

    @State private var showSheet: Bool = false
    @State private var activeSheet: ActiveSheet?
    
    @State private var fileSize: String = ""
    
    private var leadingSwipeActions: [Slot] {
        return settings.hub.usePins ? [Slot(
            image: { Image(systemName: .pinIcon).frame(width: .swipeActionLargeIconSize, height: .swipeActionLargeIconSize).embedInAnyView() },
            title: { EmptyView().embedInAnyView() },
            action: { togglePin() },
            style: .init(background: .orange, slotHeight: .swipeActionButtonSize)
        )] : []
    }

    private var trailingSwipeActions: [Slot] {
        return [Slot(
            image: { Image(systemName: .trashIcon).frame(width: .swipeActionLargeIconSize, height: .swipeActionLargeIconSize).embedInAnyView() },
            title: { EmptyView().embedInAnyView() },
            action: { deleteAction(projectData) },
            style: .init(background: .red, slotHeight: .swipeActionButtonSize)
        )]
    }
        
    enum ActiveSheet: Identifiable {
        case emoji
        case advancedSettings
        
        var id: Int {
            hashValue
        }
    }
    
    var body: some View {
        let versionBinding = Binding(
            get: { self.projectData.version },
            set: { self.projectData.version = $0 }
        )
        let emojiBinding = Binding(
            get: { self.projectData.emoji },
            set: { self.projectData.emoji = $0 }
        )
        
        return HStack {
            emojiArea(emojiBinding: emojiBinding)
            Button(action: openProject) {
                titleArea()
                if settings.hub.usePins && projectData.pinned {
                    Image(systemName: .pinIcon)
                        .font(.system(size: 10, weight: .semibold))
                        .rotationEffect(Angle(degrees: 45))
                }
                Spacer()
                if settings.hub.showFileSizes {
                    LoadingText(text: $fileSize)
                        .padding(.trailing, 8)
                }
            }
            .buttonStyle(PlainButtonStyle())
            if showWarning {
                Image(systemName: .warningIcon)
                    .help("The Editor version associated with this project is not currently available on this machine.  Go to Installs to download a matching version")
            }
            Menu {
                ForEach(settings.hub.versions) { version in
                    Button("Unity \(version.version)") {
                        projectData.version = version
                    }
                }
            } label: { Text("Unity \(versionBinding.wrappedValue.version)") }
                .frame(width: 128)
            dropDownMenu()
        }
        .contentShape(Rectangle())
        .frame(minWidth: 64, maxWidth: .infinity)
        .frame(height: .listItemHeight)
        .onAppear {
            getProjectSize()
            if !settings.hub.versions.contains(where: { $0.version == projectData.version.version }) {
                showWarning = true
            }
        }
        .sheet(item: $activeSheet) { sheetView(item: $0, emoji: emojiBinding, version: versionBinding) }
        .onSwipe(leading: leadingSwipeActions, trailing: trailingSwipeActions)
        .alert(isPresented: $showVersionWarning) {
            Alert(title: Text("Missing Unity Version"), message: Text("The Unity version last used to open this project (\(projectData.version.version)) is missing.  Please reinstall it or redownload the version."), dismissButton: .default(Text("Ok")))
        }
    }
    
    func emojiArea(emojiBinding: Binding<String>) -> some View {
        Group {
            if settings.hub.useEmoji {
                Button(action: selectEmoji) {
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
            if !settings.hub.alwaysShowLocation {
                Text(projectData.name)
                    .font(.system(size: 12, weight: .semibold))
                    .help(projectData.path)
            } else {
                Text(projectData.name)
                    .font(.system(size: 12, weight: .semibold))
                Text(projectData.path)
                    .font(.system(size: 11, weight: .regular))
                    .opacity(0.5)
            }
        }
    }
    
    func dropDownMenu() -> some View {
        Menu {
            Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: projectData.path) })
            if settings.hub.useEmoji {
                Divider()
                Button("Select Emoji", action: selectEmoji)
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
            Button("Remove Project", action: { deleteAction(projectData) })
        } label: {}
            .menuStyle(BorderlessButtonMenuStyle())
            .frame(width: 16, height: 48)
            .padding(.trailing, 16)
    }
    
    func sheetView(item: ActiveSheet, emoji: Binding<String>, version: Binding<UnityVersion>) -> some View {
        Group {
            switch item {
            case .emoji: EmojiPickerSheet(action: { emoji.wrappedValue = $0 })
            case .advancedSettings: AdvancedProjectSettingsSheet()
            }
        }
    }
    
    func getShellCommand() -> String? {
        showWarning = false
        showVersionWarning = false
        
        if settings.hub.versions.contains(projectData.version) {
            let result =  "\(settings.hub.getRealVersion(projectData.version).path)/Unity.app/Contents/MacOS/Unity -projectPath \"\(projectData.path)\""
            return result
        }
        
        showWarning = true
        showVersionWarning = true
        return nil
    }
    
    func selectEmoji() {
        activeSheet = .emoji
        showSheet.toggle()
    }
    
    func openProject() {
        if let shellCommand = getShellCommand(), !showWarning {
            DispatchQueue.global(qos: .background).async {
                _ = shell(shellCommand)
            }
        } else {
            showVersionWarning = true
        }
    }
        
    func openAdvancedSettings() {
        activeSheet = .advancedSettings
        showSheet.toggle()
    }
    
    func togglePin() {
        projectData.pinned.toggle()
        settings.save()
        updateList.toggle()
    }
    
    func getProjectSize() {
        DispatchQueue.global(qos: .background).async {
            let url = URL(fileURLWithPath: projectData.path)
            var size = ""
            do {
                size = try url.sizeOnDisk() ?? ""
            } catch {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                fileSize = size
            }
        }
    }
}
