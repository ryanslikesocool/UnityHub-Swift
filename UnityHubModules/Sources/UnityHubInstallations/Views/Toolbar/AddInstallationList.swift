import SwiftUI
import UnityHubCommon
import UnityHubStorage

struct AddInstallationList: View {
	var body: some View {
		Menu(
			content: {
				Button.downloadInstallation()
				Button.locateInstallation()
			},
			label: Label.add
		)
	}
}
