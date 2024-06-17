import SwiftUI
import UnityHubStorage

struct OpenProjectAction {
	private let appSettings: AppSettings?
	private let projectCache: ProjectCache?

	fileprivate init(appSettings: AppSettings?, projectCache: ProjectCache?) {
		self.appSettings = appSettings
		self.projectCache = projectCache
	}

	func callAsFunction(_ url: URL) throws {
		guard let appSettings else {
			throw OpenProjectActionError.missingRequiredObject(AppSettings.self)
		}
		guard let projectCache else {
			throw OpenProjectActionError.missingRequiredObject(ProjectCache.self)
		}

		print("\(Self.self).\(#function) is not implemented")
	}
}

// MARK: - Environment

private enum OpenProjectActionEnvironmentKey: EnvironmentKey {
	static let defaultValue: OpenProjectAction = OpenProjectAction(appSettings: nil, projectCache: nil)
}

extension EnvironmentValues {
	fileprivate(set) var openProject: OpenProjectAction {
		get { self[OpenProjectActionEnvironmentKey.self] }
		set { self[OpenProjectActionEnvironmentKey.self] = newValue }
	}
}

extension View {
	func openProjectAction(appSettings: AppSettings, projectCache: ProjectCache) -> some View {
		environment(\.openProject, OpenProjectAction(appSettings: appSettings, projectCache: projectCache))
	}
}
