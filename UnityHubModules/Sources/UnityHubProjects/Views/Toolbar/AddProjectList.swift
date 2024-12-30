import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorageProjects

struct AddProjectList: View {
	public init() { }

	public var body: some View {
		Menu(
			content: {
				CreateProjectButton()
				LocateProjectButton()
			},
			label: Label.add
		)
	}
}
