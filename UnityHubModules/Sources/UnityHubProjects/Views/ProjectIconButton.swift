import SwiftUI
import UnityHubStorage
import UserIcon

struct ProjectIconButton<BlankView: View>: View {
	typealias BlankProvider = () -> BlankView

	@Binding private var project: ProjectMetadata
	@State private var isPresentingSheet: Bool = false
	private let blank: BlankProvider

	init(project: Binding<ProjectMetadata>, @ViewBuilder blank: @escaping BlankProvider) {
		_project = project
		self.blank = blank
	}

	var body: some View {
		Button(action: { isPresentingSheet = true }) {
			Group {
				if project.icon == .blank && BlankView.self != EmptyView.self {
					blank()
				} else {
					UserIconView(project.icon)
				}
			}
		}
		.buttonStyle(.plain)
		.scaledToFit()
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
	init(project: Binding<ProjectMetadata>) {
		self.init(project: project, blank: EmptyView.init)
	}
}
