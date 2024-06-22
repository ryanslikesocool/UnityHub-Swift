import AppKit
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct UserMenu: View {
	var body: some View {
		Menu("User", systemImage: Constant.Symbol.person) {
			Section {
				Button("Account Settings", systemImage: Constant.Symbol.gearShape) { }
					.disabled(true)

				Link(destination: #URL("https://cloud.unity.com/login")) {
					Label("Unity Cloud", systemImage: Constant.Symbol.cloud)
				}

				Button("Manage Licenses", systemImage: Constant.Symbol.person) { }
					.disabled(true)

				Button("Manage Organizations", systemImage: Constant.Symbol.person_3_sequence) { }
					.disabled(true)
			}

			Section {
				Menu("Troubleshooting", systemImage: Constant.Symbol.questionMark) {
					Link(
						"Account Help",
						systemImage: Constant.Symbol.questionMark,
						destination: #URL("https://support.unity.com/hc/en-us/sections/201104779-Accounts-UDN")
					)

					Button(
						"Open Log Folder",
						systemImage: Constant.Symbol.folder
					) {
						URL.applicationSupportDirectory.appending(path: "UnityHub/logs", directoryHint: .isDirectory).showInFinder()
					}

					Link(
						destination: #URL("https://github.com/ryanslikesocool/UnityHub-Swift/issues"),
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
}
