import SwiftUI

extension ImageResource: ExpressibleByStringLiteral {
	public init(stringLiteral value: String.StringLiteralType) {
		self.init(name: value, bundle: .main)
	}
}
