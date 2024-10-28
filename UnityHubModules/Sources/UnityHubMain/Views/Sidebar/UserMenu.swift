import AppKit
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct UserMenu: View {
	var body: some View {
		Menu("User", systemImage: Symbol.person) {
			makeContent()
				.controlSize(.regular)
				.labelStyle(.automatic)
		}
	}
}

// MARK: - Supporting Views

private extension UserMenu {
	@ViewBuilder
	func makeContent() -> some View {
		Section {
			Button("Account Settings", systemImage: Symbol.gearShape) { }
				.disabled(true)

			RealLink(destination: Constant.Link.cloudLogin) {
				Label("Unity Cloud", systemImage: Symbol.cloud)
			}

			Button("Manage Licenses", systemImage: Symbol.person) { }
				.disabled(true)

			Button("Manage Organizations", systemImage: Symbol.person_3_sequence) { }
				.disabled(true)
		}

		Section {
			Menu("Troubleshooting", systemImage: Symbol.questionMark) {
				RealLink(
					"Account Help",
					systemImage: Symbol.questionMark,
					destination: Constant.Link.accountHelp
				)

				Button(
					"Open Log Folder",
					systemImage: Symbol.folder
				) {
					URL.applicationSupportDirectory.appending(path: "UnityHub/logs", directoryHint: .isDirectory).showInFinder()
				}

				RealLink(
					destination: Constant.Link.bugReport,
					label: Label.reportBug
				)
			}

			SettingsButton()

			Button("Sign Out", image: Symbol.rectangle_portrait_and_arrow_left, role: .destructive) { }
				.disabled(true)
		}
	}
}
