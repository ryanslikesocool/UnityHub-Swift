import Foundation
import UnityHubCommon

public extension Utility {
	enum Version {
		static func getDocumentationInfix(_ version: borrowing UnityEditorVersion) -> String {
			if version.major <= 5 {
				"\(version.major)\(version.minor)0"
			} else {
				"\(version.major).\(version.minor)"
			}
		}

		static func getDocumentationPrefixURL(_ version: borrowing UnityEditorVersion) -> URL {
			Constant.Version.documentationURL
				.appending(component: getDocumentationInfix(version))
				.appending(component: "Documentation")
		}

		public static func getManualURL(_ version: borrowing UnityEditorVersion) -> URL {
			getDocumentationPrefixURL(version)
				.appending(path: Constant.Version.documentationManualPath)
		}

		public static func getScriptReferenceURL(_ version: borrowing UnityEditorVersion) -> URL {
			getDocumentationPrefixURL(version)
				.appending(path: Constant.Version.documentationScriptReferencePath)
		}
	}
}
