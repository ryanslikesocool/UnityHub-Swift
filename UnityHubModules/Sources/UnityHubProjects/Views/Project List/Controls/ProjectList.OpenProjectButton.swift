import SwiftUI
import UnityHubCommon
import UnityHubStorage

extension ProjectList {
	struct OpenProjectButton<Label: View>: View {
		public typealias LabelProvider = () -> Label

		private let projectURL: URL
		private let editorVersion: UnityEditorVersion?
		private let label: LabelProvider

		init(
			at projectURL: URL,
			with editorVersion: UnityEditorVersion? = nil,
			@ViewBuilder label: @escaping LabelProvider
		) {
			self.projectURL = projectURL
			self.editorVersion = editorVersion
			self.label = label
		}

		var body: some View {
			Button(
				action: action,
				label: label
			)
		}
	}
}

// MARK: - Functions

private extension ProjectList.OpenProjectButton {
	func action() {
		do {
			try ProjectCache.shared.openProject(at: projectURL, with: editorVersion)
		} catch ProjectError.invalid {
			Event.Project.invalid.send()
		} catch ProjectError.missing {
			Event.Project.missing.send(projectURL)
		} catch ProjectError.unknownEditorVersion {
			fatalError("\(Self.self).\(#function) is not implemented")
		} catch let InstallationError.missingInstallationForVersion(editorVersion) {
			Event.Installation.missingVersion.send(editorVersion)
		} catch let error as ShellError {
			fatalError("\(Self.self).\(#function) is not implemented")
		} catch {
			preconditionFailure(unexpectedError: error)
		}
	}
}
