import SwiftUI

public protocol UnityEditorVersionLabelStyle {
	associatedtype Body: View
	typealias Configuration = UnityEditorVersionLabelStyleConfiguration

	@ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
}
