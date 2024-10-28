import SwiftUI
import UnityHubCommonViews
import UnityHubStorage

struct SearchTokenEditor: View {
	@CacheFile(InstallationCache.self) private var installations

	@Binding private var selection: SearchToken

	init(selection: Binding<SearchToken>) {
		_selection = selection
	}

	var body: some View {
		switch selection {
			case let .lts(value): ltsEditor(value: value)
			case let .prerelease(value): prereleaseEditor(value: value)
			case let .majorVersion(value): majorEditor(value: value)
		}
	}
}

// MARK: - Supporting Views

private extension SearchTokenEditor {
	func ltsEditor(value: Bool) -> some View {
		let binding = Binding<Bool>(
			get: { value },
			set: { selection = .lts($0) }
		)

		return Picker("LTS", selection: binding) {
			Text("Is").tag(true)
			Text("Is Not").tag(false)
		}
	}

	func prereleaseEditor(value: Bool) -> some View {
		let binding = Binding<Bool>(
			get: { value },
			set: { selection = .prerelease($0) }
		)

		return Picker("Prerelease", selection: binding) {
			Text("Is").tag(true)
			Text("Is Not").tag(false)
		}
	}

	func majorEditor(value: SemanticVersion.Integer) -> some View {
		let binding = Binding<SemanticVersion.Integer>(
			get: { value },
			set: { selection = .majorVersion($0) }
		)

		return Picker("Major Version", selection: binding) {
			ForEach(installations.uniqueMajorVersions, id: \.self) { value in
				Text(value.description).tag(value)
			}
		}
	}
}
