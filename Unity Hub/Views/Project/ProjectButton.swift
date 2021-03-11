//
//  ProjectButton.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import SwiftUI
import Cocoa
import AppKit
import Foundation
import Dispatch

struct ProjectButton: View {
    @EnvironmentObject var settings: HubSettings

    @State var metadata: ProjectMetadata
    @Binding var updateList: Bool
        
    var deleteAction: (ProjectMetadata) -> Void
    
    @State private var shellCommand: String? = nil
    @State private var showWarning: Bool = false

    @State private var showSheet: Bool = false
    @State private var activeSheet: ActiveSheet?
    
    private var leadingSwipeActions: [Slot] {
        get {
            return [Slot(
                image: { Image(systemName: "pin.fill").frame(width: 24, height: 24).embedInAnyView() },
                title: { EmptyView().embedInAnyView() },
                action: { togglePin() },
                style: .init(background: .orange, slotHeight: 64)
            )]
        }
    }
    private var trailingSwipeActions: [Slot] {
        get {
            return [Slot(
                image: { Image(systemName: "trash.fill").frame(width: 24, height: 24).embedInAnyView() },
                title: { EmptyView().embedInAnyView() },
                action: { deleteAction(metadata) },
                style: .init(background: .red, slotHeight: 64)
            )]
        }
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
            get: { self.metadata.version },
            set: { self.metadata.version = $0 }
        )
        let emojiBinding = Binding(
            get: { self.metadata.emojiTag },
            set: { self.metadata.emojiTag = $0 }
        )
        
        return HStack {
            emojiArea(emojiBinding: emojiBinding)
            titleArea()
            pinArea()
            Spacer()
            versionArea(versionBinding: versionBinding)
            dropDownMenu()
        }
        .contentShape(Rectangle())
        .frame(minWidth: 64, maxWidth: .infinity, minHeight: 64, maxHeight: 64)
        .onAppear { shellCommand = getShellCommand() }
        .sheet(item: $activeSheet) { sheetView(item: $0, emoji: emojiBinding, version: versionBinding) }
        .onSwipe(leading: leadingSwipeActions, trailing: trailingSwipeActions)
    }
    
    func emojiArea(emojiBinding: Binding<String>) -> some View {
        Group {
            if settings.useEmoji {
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
            if !settings.alwaysShowLocation {
                Text(metadata.name)
                    .font(.system(size: 12, weight: .semibold))
                    .help(metadata.path)
            } else {
                Text(metadata.name)
                    .font(.system(size: 12, weight: .semibold))
                Text(metadata.path)
                    .font(.system(size: 11, weight: .regular))
                    .opacity(0.5)
            }
        }
    }
    
    func pinArea() -> some View {
        Group {
            if settings.usePins && metadata.pinned {
                Image(systemName: "pin.fill")
                    .font(.system(size: 10, weight: .semibold))
                    .rotationEffect(Angle(degrees: 45))
            }
        }
    }
    
    func versionArea(versionBinding: Binding<UnityVersion>) -> some View {
        Group {
            if showWarning {
                Image(systemName: "exclamationmark.triangle.fill")
                    .help("The Editor version associated with this project is not currently available on this machine.  Go to Installs to download a matching version")
            }
            Text("Unity \(versionBinding.wrappedValue.version)")
                .opacity(0.75)
        }
    }
    
    func dropDownMenu() -> some View {
        Menu {
            Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: metadata.path) })
            if settings.useEmoji {
                Button("Select Emoji", action: selectEmoji)
            }
            if settings.usePins {
                Button("Toggle Pin", action: togglePin)
            }
            Button("Select Unity Version", action: selectProjectVersion)
            //Button("Advanced", action: openAdvancedSettings)
            Button("Remove Project", action: { deleteAction(metadata) })
        } label: {}
        .menuStyle(BorderlessButtonMenuStyle())
        .frame(width: 16, height: 48)
        .padding(.trailing, 16)
    }
    
    func sheetView(item: ActiveSheet, emoji: Binding<String>, version: Binding<UnityVersion>) -> some View {
        Group {
            switch item {
            case .emoji: EmojiPickerSheet(pickedEmoji: emoji, action: { metadata.save() })
            case .selectVersion: SelectProjectVersionSheet(version: version, action: {
                shellCommand = getShellCommand()
                metadata.save()
            })
            case .advancedSettings: AdvancedProjectSettingsSheet()
            }
        }
    }
    
    func getShellCommand() -> String? {
        showWarning = false
        
        for version in settings.versionsInstalled {
            if version == self.metadata.version
            {
                let fullUnityPath = "\(version.path)/Unity.app/Contents/MacOS/Unity"
                let commands = "-projectPath"
                return "\(fullUnityPath) \(commands) \(metadata.path)"
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
                let _ = shell(shellCommand!)
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
        metadata.pinned.toggle()
        metadata.save()
        updateList.toggle()
    }
}
