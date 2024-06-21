import SwiftUI

public struct ProjectsView: View {
	public init() { }

	public var body: some View {
		ProjectList()
			.toolbar {
				ToolbarItemGroup(placement: .confirmationAction) {
					AddProjectList()
					SortMenu()
					InfoVisibilityMenu()
				}
			}

			/// cannot combine event receivers into a single `.background`
			/// for some reason, `EmptyView` works if done this way
			.background(content: LocateProjectReceiver.init)
			.background(content: RemoveProjectReceiver.init)
			.background(content: InvalidProjectReceiver.init)
			.background(content: DisplayProjectInfoReceiver.init)
			.background(content: MissingProjectReceiver.init)
			.background(content: CreateProjectReceiver.init)
	}
}
