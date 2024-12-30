import SwiftUI
import UnityHubStorageInstallations

public struct UnityEditorVersionList<Content>: View where
	Content: View
{
	private let versions: [UnityEditorVersion]
	private let uniqueMajorVersions: [UnityEditorVersion.Integer]?
	private let makeContent: (UnityEditorVersion) -> Content

	public init(
		versions: some Sequence<UnityEditorVersion>,
		groupByMajorVersion: Bool = true,
		@ViewBuilder content: @escaping (UnityEditorVersion) -> Content
	) {
		self.versions = Set(versions).sorted()
		makeContent = content

		uniqueMajorVersions = if groupByMajorVersion {
			versions.uniqueMajorVersions
		} else {
			nil
		}
	}

	public var body: some View {
		if let uniqueMajorVersions {
			makeGrouped(uniqueMajorVersions: uniqueMajorVersions)
		} else {
			makeUngrouped(versions: versions)
		}
	}
}

// MARK: - Supporting Views

private extension UnityEditorVersionList {
	func makeUngrouped(versions: [UnityEditorVersion]) -> some View {
		ForEach(versions, content: makeContent)
	}

	func makeGrouped(uniqueMajorVersions: [UnityEditorVersion.Integer]) -> some View {
		ForEach(uniqueMajorVersions, id: \.self) { majorVersion in
			Section {
				makeMajorVersionSection(majorVersion: majorVersion)
			}
		}
	}

	func makeMajorVersionSection(majorVersion: UnityEditorVersion.Integer) -> some View {
		let versionsInMajor = versions
			.filter { version in version.major == majorVersion }

		return makeUngrouped(versions: versionsInMajor)
	}
}
