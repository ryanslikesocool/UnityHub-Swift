import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(UnityHubMacros)
@testable import UnityHubMacros

private let testMacros: [String: Macro.Type] = [
	"URL": URLMacro.self,
]
#endif

final class URLMacroTests: XCTestCase {
	func testPrimary() throws {
#if canImport(UnityHubMacros)
		assertMacroExpansion(
			#"#URL("https://developedwith.love/")"#,
			expandedSource:
			#"URL(string: "https://developedwith.love/")!"#,
			macros: testMacros
		)
#else
		throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
	}
}
