import SwiftUI

struct RecalculateFileSizeAction {
	private let projectListState: ProjectListState?

	fileprivate init(projectListState: ProjectListState?) {
		self.projectListState = projectListState
	}

	func callAsFunction(for url: URL) throws {
		guard let projectListState else {
			throw RecalculateFileSizeActionError.missingRequiredObject(ProjectListState.self)
		}

		projectListState.recalculateFileSize(for: url)
	}
}

// MARK: - Environment

private enum RecalculateFileSizeActionEnvironmentKey: EnvironmentKey {
	static let defaultValue: RecalculateFileSizeAction = RecalculateFileSizeAction(projectListState: nil)
}

extension EnvironmentValues {
	fileprivate(set) var recalculateFileSize: RecalculateFileSizeAction {
		get { self[RecalculateFileSizeActionEnvironmentKey.self] }
		set { self[RecalculateFileSizeActionEnvironmentKey.self] = newValue }
	}
}

extension View {
	func recalcualteFileSize(projectListState: ProjectListState) -> some View {
		environment(\.recalculateFileSize, RecalculateFileSizeAction(projectListState: projectListState))
	}
}
