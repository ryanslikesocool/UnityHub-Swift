import Foundation
import SwiftCompilerPluginMessageHandling
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacros

/// This macro is based on
/// [this approach](https://www.avanderlee.com/swift/macros/)
/// by Antoine van der Lee.
public struct URLMacro: ExpressionMacro {
	public static func expansion(
		of node: some FreestandingMacroExpansionSyntax,
		in context: some MacroExpansionContext
	) throws -> ExprSyntax {
		guard
			let argument = node.arguments.first?.expression,
			let segments = argument.as(StringLiteralExprSyntax.self)?.segments,
			segments.count == 1,
			case let .stringSegment(literalSegment)? = segments.first
		else {
			throw Diagnostic.requiresStaticStringLiteral
		}

		guard let _ = URL(string: literalSegment.content.text) else {
			throw Diagnostic.malformedURL(urlString: "\(argument)")
		}

		return "URL(string: \(argument))!"
	}
}
