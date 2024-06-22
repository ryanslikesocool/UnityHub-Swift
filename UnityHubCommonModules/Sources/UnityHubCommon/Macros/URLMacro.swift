import Foundation

/// A macro that produces an unwrapped URL in case of a valid input URL.
@freestanding(expression)
public macro URL(_ stringLiteral: String) -> URL = #externalMacro(module: "UnityHubMacros", type: "URLMacro")
