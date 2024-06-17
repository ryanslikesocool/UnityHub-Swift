import SwiftUI
import UnityHubProjectStorage
import UserIcon

struct ProjectIconButton<BlankView: View>: View {
	typealias BlankProvider = () -> BlankView

	@Binding private var project: ProjectInfo
	@State private var isPresentingSheet: Bool = false
	private let blank: BlankProvider

	init(project: Binding<ProjectInfo>, @ViewBuilder blank: @escaping BlankProvider) {
		_project = project
		self.blank = blank
	}

	var body: some View {
		Button(action: { isPresentingSheet = true }) {
			if project.icon == .blank && BlankView.self != EmptyView.self {
				blank()
			} else {
				UserIconView(project.icon)
			}
		}
		.buttonStyle(.plain)
		.frame(height: 36)
		.sheet(isPresented: $isPresentingSheet, content: sheetContent)
	}
}

// MARK: - Supporting Views

private extension ProjectIconButton {
	func sheetContent() -> some View {
		VStack(spacing: 0) {
			HStack {
				Text(project.name)
					.font(.headline)

				Spacer()

				Button("Done", role: .cancel) { isPresentingSheet = false }
			}
			.padding()
			Divider()
			UserIconEditor(selection: $project.icon)
				.userIconEditorStyle(.horizontal)
		}
	}
}

// MARK: - Init+

extension ProjectIconButton
	where BlankView == EmptyView
{
	init(project: Binding<ProjectInfo>) {
		self.init(project: project, blank: EmptyView.init)
	}
}
