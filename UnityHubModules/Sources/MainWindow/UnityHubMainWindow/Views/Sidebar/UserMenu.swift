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
			Button(
				String(localized: .userMenu.item.accountSettings),
				systemImage: .gearShape
			) { }
				.disabled(true)

			RealLink(
				String(localized: .userMenu.item.unityCloud),
				systemImage: .cloud,
				destination: .unityResource.cloudLogin
			)

			Button(
				String(localized: .userMenu.item.manageLicenses),
				systemImage: .person
			) { }
				.disabled(true)

			Button(
				String(localized: .userMenu.item.manageOrganizations),
				systemImage: .person_3_sequence
			) { }
				.disabled(true)
		}

		Section {
			Menu(
				String(localized: .userMenu.group.troubleshooting),
				systemImage: .questionMark
			) {
				RealLink(
					String(localized: .userMenu.item.accountHelp),
					systemImage: .questionMark,
					destination: .unityResource.accountHelp
				)

				Button(
					String(localized: .userMenu.item.openLogFolder),
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

			Button(
				String(localized: .userMenu.item.signOut),
				image: .rectangle_portrait_and_arrow_left,
				role: .destructive
			) {
				fatalError("\(Self.self).\(#function) is not implemented")
			}
			.disabled(true)
		}
	}
}
