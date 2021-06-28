//
//  Settingsview.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct SettingsView: View {
	@EnvironmentObject var settings: AppState

	var body: some View {
		ScrollView {
			Form {
				Section(header: sectionLabel("Locations")) {
					locationSection()
				}
				Divider()
				Section(header: sectionLabel("Sidebar")) {
					sidebarSection()
				}
				Divider()
				Section(header: sectionLabel("Project Panel")) {
					projectPanelSection()
				}
				Divider()
				Section(header: sectionLabel("All Panels")) {
					allPanelsSection()
				}
			}
			.padding()
		}
	}

	func sectionLabel(_ text: String) -> some View {
		return Text(text).font(.title2)
	}

	func locationSection() -> some View {
		return Group {
			LocationSetting(label: "Unity Hub Location", symbol: "folder", prompt: "Choose Unity Hub.app", isDirectory: false, assignAction: { settings.hub.hubLocation = $0 }, location: settings.hub.hubLocation, isFirst: true)
			LocationSetting(label: "Default Editor Location", symbol: "folder", prompt: "Choose the default editor location", isDirectory: true, assignAction: {
				settings.hub.installLocation = $0
				settings.setVersionDefaultLocation()
			}, location: settings.hub.installLocation)
			LocationSetting(label: "Default Project Location", symbol: "folder", prompt: "Choose the default project location", isDirectory: true, assignAction: { settings.hub.projectLocation = $0 }, location: settings.hub.projectLocation, isLast: true)
		}
	}

	func sidebarSection() -> some View {
		return Group {
			ToggleSetting(label: "Use Small Sidebar", toggle: $settings.hub.useSmallSidebar, isFirst: true)
				.disabled(true)
			ToggleSetting(label: "Show Item Count", toggle: $settings.hub.showSidebarCount, isLast: true)
				.disabled(settings.hub.useSmallSidebar)
		}
	}

	func projectPanelSection() -> some View {
		return Group {
			ToggleSetting(label: "Use Emoji", toggle: $settings.hub.useEmoji, isFirst: true)
			ToggleSetting(label: "Use Pins", toggle: $settings.hub.usePins, isLast: true)
		}
	}

	func allPanelsSection() -> some View {
		return Group {
			ToggleSetting(label: "Show File Location", toggle: $settings.hub.showLocation, isFirst: true)
			ToggleSetting(label: "Show File Size", toggle: $settings.hub.showFileSize, isLast: true)
		}
	}
}
