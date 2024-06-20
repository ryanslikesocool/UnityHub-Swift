import SwiftUI

public protocol URLLabelStyle {
	associatedtype Body: View
	typealias Configuration = URLLabelStyleConfiguration

	@ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
}
