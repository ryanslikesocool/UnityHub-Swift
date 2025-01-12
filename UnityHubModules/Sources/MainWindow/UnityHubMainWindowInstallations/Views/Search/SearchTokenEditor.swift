import SwiftUI
import UnityHubCommonViews
import UnityHubStorageCommon
import UnityHubStorageInstallations

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
			set: { newValue in selection = .lts(newValue) }
		)

		return Picker(
			.unityEditorVersion.longTermSupport,
			selection: binding
		) {
			Text(.booleanSearchToken.item.is).tag(true)
			Text(.booleanSearchToken.item.isNot).tag(false)
		}
	}

	func prereleaseEditor(value: Bool) -> some View {
		let binding = Binding<Bool>(
			get: { value },
			set: { newValue in selection = .prerelease(newValue) }
		)

		return Picker(
			.unityEditorVersion.prerelease,
			selection: binding
		) {
			Text(.booleanSearchToken.item.is).tag(true)
			Text(.booleanSearchToken.item.isNot).tag(false)
		}
	}

	func majorEditor(value: SemanticVersion.Integer) -> some View {
		let binding = Binding<SemanticVersion.Integer>(
			get: { value },
			set: { newValue in selection = .majorVersion(newValue) }
		)

		return Picker(
			.unityEditorVersion.semanticVersion.major,
			selection: binding
		) {
			ForEach(installations.uniqueMajorVersions, id: \.self) { value in
				Text(value.description).tag(value)
			}
		}
	}
}
