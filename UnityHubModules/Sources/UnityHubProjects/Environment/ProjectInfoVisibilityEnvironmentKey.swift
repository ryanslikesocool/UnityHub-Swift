import SwiftUI
import UnityHubStorage

private enum ProjectInfoVisibilityEnvironmentKey: EnvironmentKey {
	static let defaultValue: ProjectInfoVisibility.Mask = .all
}

extension EnvironmentValues {
	fileprivate(set) var projectInfoVisibility: ProjectInfoVisibility.Mask {
		get { self[ProjectInfoVisibilityEnvironmentKey.self] }
		set { self[ProjectInfoVisibilityEnvironmentKey.self] = newValue }
	}
}

extension View {
	func projectInfoVisibility(_ mask: ProjectInfoVisibility.Mask) -> some View {
		environment(\.projectInfoVisibility, mask)
	}
}
