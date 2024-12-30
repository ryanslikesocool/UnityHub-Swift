import SwiftUI

public struct EqualWidthHStack<Content>: View where
	Content: View
{
	private let alignment: VerticalAlignment
	private let spacing: CGFloat?
	private let content: () -> Content

	public init(
		alignment: VerticalAlignment = .center,
		spacing: CGFloat? = nil,
		@ViewBuilder content: @escaping () -> Content
	) {
		self.alignment = alignment
		self.spacing = spacing
		self.content = content
	}

	public var body: some View {
		HStack(alignment: alignment, spacing: spacing) {
			EqualWidthHStackLayout {
				content()
			}
		}
	}
}
