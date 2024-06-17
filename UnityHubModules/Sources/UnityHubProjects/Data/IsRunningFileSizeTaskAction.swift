import SwiftUI

struct IsRunningFileSizeTaskAction {
	private let projectListState: ProjectListState?

	fileprivate init(projectListState: ProjectListState?) {
		self.projectListState = projectListState
	}

	func callAsFunction(for url: URL) throws -> Bool {
		guard let projectListState else {
			throw IsRunningFileSizeTaskActionError.missingRequiredObject(ProjectListState.self)
		}

		return projectListState.isRunningFileSizeTask(for: url)
	}
}

// MARK: - Environment

private enum IsRunningFileSizeTaskActionEnvironmentKey: EnvironmentKey {
	static let defaultValue: IsRunningFileSizeTaskAction = IsRunningFileSizeTaskAction(projectListState: nil)
}

extension EnvironmentValues {
	fileprivate(set) var isRunningFileSizeTask: IsRunningFileSizeTaskAction {
		get { self[IsRunningFileSizeTaskActionEnvironmentKey.self] }
		set { self[IsRunningFileSizeTaskActionEnvironmentKey.self] = newValue }
	}
}

extension View {
	func isRunningFileSizeTaskAction(projectListState: ProjectListState) -> some View {
		environment(\.isRunningFileSizeTask, IsRunningFileSizeTaskAction(projectListState: projectListState))
	}
}
