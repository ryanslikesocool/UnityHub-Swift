public extension Sequence<UnityEditorVersion> {
	var uniqueMajorVersions: [SemanticVersion.Integer] {
		Set(map(\.major))
			.sorted()
	}
}
