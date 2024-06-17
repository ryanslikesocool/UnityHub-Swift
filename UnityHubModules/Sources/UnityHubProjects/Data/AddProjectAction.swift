import SwiftUI
import UnityHubSettingsStorage

struct AddProjectAction {
	private let appSettings: AppSettings?
	private let projectListState: ProjectListState?

	fileprivate init(appSettings: AppSettings?, projectListState: ProjectListState?) {
		self.appSettings = appSettings
		self.projectListState = projectListState
	}

	func callAsFunction(at url: URL) throws {
		guard let appSettings else {
			throw AddProjectActionError.missingRequiredObject(AppSettings.self)
		}
		guard let projectListState else {
			throw AddProjectActionError.missingRequiredObject(ProjectListState.self)
		}
		guard !appSettings.projects.projectMetadata.contains(where: { $0.url == url }) else {
			throw AddProjectActionError.projectAlreadyExists
		}
		guard url.isValidUnityProject else {
			throw AddProjectActionError.invalidUnityProject
		}
		let metadata = ProjectUserMetadata(url: url)
		appSettings.projects.projectMetadata.insert(metadata)
		projectListState.addProject(metadata)
	}
}

// MARK: - Environment

private enum AddProjectActionEnvironmentKey: EnvironmentKey {
	static let defaultValue: AddProjectAction = AddProjectAction(appSettings: nil, projectListState: nil)
}

extension EnvironmentValues {
	fileprivate(set) var addProject: AddProjectAction {
		get { self[AddProjectActionEnvironmentKey.self] }
		set { self[AddProjectActionEnvironmentKey.self] = newValue }
	}
}

extension View {
	func addProjectAction(appSettings: AppSettings, projectListState: ProjectListState) -> some View {
		environment(\.addProject, AddProjectAction(appSettings: appSettings, projectListState: projectListState))
	}
}
