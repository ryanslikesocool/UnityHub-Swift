import SwiftUI
import UnityHubSettingsStorage

struct RemoveProjectAction {
	private let appSettings: AppSettings?
	private let projectListState: ProjectListState?

	fileprivate init(appSettings: AppSettings?, projectListState: ProjectListState?) {
		self.appSettings = appSettings
		self.projectListState = projectListState
	}

	func callAsFunction(_ url: URL) throws {
		guard let appSettings else {
			throw RemoveProjectActionError.missingRequiredObject(AppSettings.self)
		}
		guard let projectListState else {
			throw RemoveProjectActionError.missingRequiredObject(ProjectListState.self)
		}

		appSettings.projects.projectMetadata = appSettings.projects.projectMetadata.filter { $0.url != url }
		projectListState.removeProject(at: url)
	}
}

// MARK: - Environment

private enum RemoveProjectActionEnvironmentKey: EnvironmentKey {
	static let defaultValue: RemoveProjectAction = RemoveProjectAction(appSettings: nil, projectListState: nil)
}

extension EnvironmentValues {
	fileprivate(set) var removeProject: RemoveProjectAction {
		get { self[RemoveProjectActionEnvironmentKey.self] }
		set { self[RemoveProjectActionEnvironmentKey.self] = newValue }
	}
}

extension View {
	func removeProjectAction(appSettings: AppSettings, projectListState: ProjectListState) -> some View {
		environment(\.removeProject, RemoveProjectAction(appSettings: appSettings, projectListState: projectListState))
	}
}
