import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubStorage
import UserIcon

extension ProjectList {
	struct Item: View {
		@Bindable private var appSettings: AppSettings = .shared
		@Bindable private var projectCache: ProjectCache = .shared

		@State private var isPresentingDetails: Bool = false

		@Binding private var project: ProjectMetadata

		init(_ project: Binding<ProjectMetadata>) {
			_project = project
		}

		var body: some View {
			content
				.padding(4)
				.frame(minHeight: 24)
				.contextMenu {
					contextMenu
				}
				.sheet(isPresented: $isPresentingDetails) {
					ProjectInfoView($project)
				}
		}
	}
}

// MARK: - Supporting Views

private extension ProjectList.Item {
	var content: some View {
		HStack {
			Button(action: onOpenProject) {
				ButtonLabel($project)
			}
			.buttonStyle(.plain)

			editorVersion
		}
	}

	@ViewBuilder var editorVersion: some View {
		if
			appSettings.projects.infoVisibility.contains(.editorVersion),
			let editorVersion = project.editorVersion
		{
			UnityEditorVersionLabel(editorVersion)
		}
	}
}

// MARK: - Context Menu

private extension ProjectList.Item {
	@ViewBuilder var contextMenu: some View {
		Section {
			Button("Details", systemImage: "info") { isPresentingDetails = true }
				.keyboardShortcut("i")
		}

		Section {
			Button("Show in Finder", action: project.url.showInFinder)
		}

		Section {
			Button("Remove", systemImage: "trash", role: .destructive) {
				Event.removeProject(project.url)
			}
			.keyboardShortcut(.delete)
		}
	}
}

// MARK: - Functions

private extension ProjectList.Item {
	func onOpenProject() {
		do {
			try projectCache.openProject(at: project.url)
		} catch ProjectCache.ProjectError.invalid {
			Event.invalidProject()
		} catch {
			preconditionFailure("""
			Caught an unexpected error:
			\(error.localizedDescription)
			""")
		}
	}
}
