import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage

extension ProjectList {
	struct OpenProjectWithVersionMenu: View {
		@Cache(InstallationCache.self) private var installations

		@Binding private var project: ProjectMetadata

		public init(project: Binding<ProjectMetadata>) {
			_project = project
		}

		public var body: some View {
			Menu(
				content: makeContent,
				label: Label.openWith
			)
		}
	}
}

// MARK: - Supporting Views

private extension ProjectList.OpenProjectWithVersionMenu {
	func makeContent() -> some View {
		let versions = installations.installations
			.compactMap { try? $0.version }

		return UnityEditorVersionList(versions: versions, content: makeButton)
	}

	private func makeButton(version: UnityEditorVersion) -> some View {
		let isSelected: Bool = version == project.editorVersion

		return ProjectList.OpenProjectButton(at: project.url, with: version) {
			Label(version.description, systemImage: Constant.Symbol.checkmark)
				.labelStyle(isSelected ? AnyLabelStyle(.titleAndIcon) : AnyLabelStyle(.titleOnly))
		}
//		.disabled(isSelected)
	}
}