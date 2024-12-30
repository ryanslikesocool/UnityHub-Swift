import AppKit
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct UserMenu: View {
	var body: some View {
		Menu("User", systemImage: .person) {
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
			Button("Account Settings", systemImage: .gearShape) { }
				.disabled(true)

			RealLink(destination: .unityResource.cloudLogin) {
				Label("Unity Cloud", systemImage: .cloud)
			}

			Button("Manage Licenses", systemImage: .person) { }
				.disabled(true)

			Button("Manage Organizations", systemImage: .person_3_sequence) { }
				.disabled(true)
		}

		Section {
			Menu("Troubleshooting", systemImage: .questionMark) {
				RealLink(
					"Account Help",
					systemImage: .questionMark,
					destination: .unityResource.accountHelp
				)

				Button(
					"Open Log Folder",
					systemImage: .folder
				) {
					URL.UnityResource.logDirectory
						.showInFinder()
				}

				RealLink(
					destination: .unityResource.bugReport,
					label: Label.reportBug
				)
			}

			SettingsButton()

			Button("Sign Out", image: .rectangle_portrait_and_arrow_left, role: .destructive) {
				fatalError("\(Self.self).\(#function) is not implemented")
			}
			.disabled(true)
		}
	}
}
