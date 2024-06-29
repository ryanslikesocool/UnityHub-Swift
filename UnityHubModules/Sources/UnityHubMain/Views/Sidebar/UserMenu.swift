import AppKit
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct UserMenu: View {
	var body: some View {
		Menu("User", systemImage: Constant.Symbol.person) {
			content
				.labelStyle(.automatic)
		}
	}
}

// MARK: - Supporting Views

private extension UserMenu {
	@ViewBuilder var content: some View {
		Section {
			Button("Account Settings", systemImage: Constant.Symbol.gearShape) { }
				.disabled(true)

			RealLink(destination: Constant.Link.cloudLogin) {
				Label("Unity Cloud", systemImage: Constant.Symbol.cloud)
			}

			Button("Manage Licenses", systemImage: Constant.Symbol.person) { }
				.disabled(true)

			Button("Manage Organizations", systemImage: Constant.Symbol.person_3_sequence) { }
				.disabled(true)
		}

		Section {
			Menu("Troubleshooting", systemImage: Constant.Symbol.questionMark) {
				RealLink(
					"Account Help",
					systemImage: Constant.Symbol.questionMark,
					destination: Constant.Link.accountHelp
				)

				Button(
					"Open Log Folder",
					systemImage: Constant.Symbol.folder
				) {
					URL.applicationSupportDirectory.appending(path: "UnityHub/logs", directoryHint: .isDirectory).showInFinder()
				}

				RealLink(
					destination: Constant.Link.bugReport,
					label: Label.reportBug
				)
			}

			SettingsLink {
				Label("Settings", image: Constant.Symbol.gearShape)
			}
			.keyboardShortcut(Constant.Hotkey.settings)

			Button("Sign Out", image: Constant.Symbol.rectangle_portrait_and_arrow_left, role: .destructive) { }
				.disabled(true)
		}
	}
}
