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
    
    @State private var shellCommand: String? = nil
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
        case selectVersion
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
            versionArea(versionBinding: versionBinding)
            dropDownMenu()
        }
        .contentShape(Rectangle())
        .frame(minWidth: 64, maxWidth: .infinity)
        .frame(height: .listItemHeight)
        .onAppear {
            shellCommand = getShellCommand()
            getProjectSize()
        }
        .sheet(item: $activeSheet) { sheetView(item: $0, emoji: emojiBinding, version: versionBinding) }
        .onSwipe(leading: leadingSwipeActions, trailing: trailingSwipeActions)
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
    
    func versionArea(versionBinding: Binding<UnityVersion>) -> some View {
        Group {
            if showWarning {
                Image(systemName: .warningIcon)
                    .help("The Editor version associated with this project is not currently available on this machine.  Go to Installs to download a matching version")
            }
            Text("Unity \(versionBinding.wrappedValue.version)")
                .opacity(0.75)
        }
    }
    
    func dropDownMenu() -> some View {
        Menu {
            Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: projectData.path) })
            Divider()
            if settings.hub.useEmoji {
                Button("Select Emoji", action: selectEmoji)
            }
            if settings.hub.usePins {
                Button("Toggle Pin", action: togglePin)
            }
            Divider()
            Button("Select Unity Version", action: selectProjectVersion)
            // Button("Advanced", action: openAdvancedSettings)
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
            case .selectVersion: SelectProjectVersionSheet(version: version, action: { shellCommand = getShellCommand() })
            case .advancedSettings: AdvancedProjectSettingsSheet()
            }
        }
    }
    
    func getShellCommand() -> String? {
        showWarning = false
        
        for version in settings.hub.versions {
            if version == projectData.version {
                let fullUnityPath = "\(version.path)/Unity.app/Contents/MacOS/Unity"
                let commands = "-projectPath"
                return "\(fullUnityPath) \(commands) \(projectData.path)"
            }
        }
        
        showWarning = true
        return nil
    }
    
    func selectEmoji() {
        activeSheet = .emoji
        showSheet.toggle()
    }
    
    func openProject() {
        if !showWarning {
            DispatchQueue.global(qos: .background).async {
                _ = shell(shellCommand!)
            }
        } else {
            selectProjectVersion()
        }
    }
    
    func selectProjectVersion() {
        activeSheet = .selectVersion
        showSheet.toggle()
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
