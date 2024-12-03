import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubStorage

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
