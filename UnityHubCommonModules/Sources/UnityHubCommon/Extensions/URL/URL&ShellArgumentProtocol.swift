import Foundation

extension URL: ShellArgumentProtocol {
	public var shellArgument: String { "\"\(path(percentEncoded: false))\"" }
}
