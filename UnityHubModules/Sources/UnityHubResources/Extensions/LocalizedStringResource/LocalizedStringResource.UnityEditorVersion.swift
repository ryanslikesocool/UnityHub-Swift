import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	static let unityEditorVersion = UnityEditorVersion.self

	/// ## Topics
	/// - ``unityEditorVersion``
	enum UnityEditorVersion {
		private static let localizationTable = LocalizationTableResource("UnityEditorVersion")

		public static let semanticVersion = SemanticVersion.self

		public static let longTermSupport = LocalizedStringResource("LONG_TERM_SUPPORT", table: localizationTable)
		public static let longTermSupport_verbose = LocalizedStringResource("LONG_TERM_SUPPORT.VERBOSE", table: localizationTable)
		public static let prerelease = LocalizedStringResource("PRERELEASE", table: localizationTable)

		/// ## Topics
		/// - ``semanticVersion``
		public enum SemanticVersion {
			public static let major = LocalizedStringResource("SEMANTIC_VERSION.MAJOR", table: localizationTable)
			public static let minor = LocalizedStringResource("SEMANTIC_VERSION.MINOR", table: localizationTable)
			public static let patch = LocalizedStringResource("SEMANTIC_VERSION.PATCH", table: localizationTable)
		}
	}
}
