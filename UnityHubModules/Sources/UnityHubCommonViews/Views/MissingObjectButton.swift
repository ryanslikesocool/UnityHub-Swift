import SwiftUI
import UnityHubCommon

public struct MissingObjectButton: View {
	public typealias Action = () -> Void

	private let action: Action

	public init(action: @escaping Action) {
		self.action = action
	}

	public var body: some View {
		Button(action: action) {
			Image(systemName: Constant.Symbol.exclamationMark_triangle_fill)
//				.symbolEffect(.pulse.wholeSymbol, options: .repeating) // increases engery usage a lot for some reason?
				.symbolRenderingMode(.monochrome)
				.font(.title2)
				.frame(width: Constant.ListItem.height - 16, height: Constant.ListItem.height - 4)
		}
		.tint(.yellow)
		.buttonStyle(.borderedProminent)
		.controlSize(.large)
	}
}
