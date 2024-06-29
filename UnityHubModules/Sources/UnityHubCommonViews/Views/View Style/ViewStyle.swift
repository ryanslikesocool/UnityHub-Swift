import SwiftUI

public protocol ViewStyle<Configuration> {
	associatedtype Configuration: ViewStyleConfiguration
	associatedtype Body: View

	@ViewBuilder func makeBody(configuration: Configuration) -> Body
}
