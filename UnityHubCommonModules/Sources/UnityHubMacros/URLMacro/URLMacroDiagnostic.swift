import SwiftDiagnostics

extension URLMacro {
	enum Diagnostic: Error {
		case requiresStaticStringLiteral
		case malformedURL(urlString: String)

		var id: String {
			switch self {
				case .requiresStaticStringLiteral: "requiresStaticStringLiteral"
				case .malformedURL: "malformedURL"
			}
		}
	}
}

extension URLMacro.Diagnostic: DiagnosticMessage {
	var severity: DiagnosticSeverity { .error }

	var diagnosticID: MessageID { MessageID(domain: "StarlightCommonMacros", id: id) }

	var message: String {
		switch self {
			case .requiresStaticStringLiteral: "#URL requires a static string literal"
			case let .malformedURL(urlString): "The input URL is malformed: \(urlString)"
		}
	}
}
