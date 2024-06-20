import SwiftUI

public protocol URLPickerStyle {
	associatedtype Body: View
	typealias Configuration = URLPickerStyleConfiguration

	@ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
}
