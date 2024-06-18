import AppKit
import UnityHubCommon
import SwiftUI

struct UserMenu: View {
	var body: some View {
		Menu("User", systemImage: "person") {
			Group {
				Section {
					Button("Account Settings", systemImage: "gearshape") { }
						.disabled(true)

					Link(destination: URL(string: "https://cloud.unity.com/login")!) {
						Label("Unity Cloud", systemImage: "cloud")
					}

					Button("Manage Licenses", systemImage: "person") { }
						.disabled(true)

					Button("Manage Organizations", systemImage: "person.3.sequence") { }
						.disabled(true)
				}

				Section {
					Menu {
						Link(destination: URL(string: "https://support.unity.com/hc/en-us/sections/201104779-Accounts-UDN")!) {
							Label("Account Help", systemImage: "questionmark")
						}

						Button("Open Log Folder", systemImage: "folder") {
							URL.applicationSupportDirectory.appending(path: "UnityHub/logs", directoryHint: .isDirectory).showInFinder()
						}

						Link(destination: URL(string: "https://github.com/ryanslikesocool/UnityHub-Swift/issues")!) {
							Label("Report a Bug", systemImage: "ant")
						}
					} label: {
						Label("Troubleshooting", systemImage: "questionmark")
					}

					Button("Sign Out", image: ImageResource(name: "rectangle.portrait.and.arrow.left", bundle: .main), role: .destructive) { }
						.disabled(true)
				}
			}
		}
	}
}
