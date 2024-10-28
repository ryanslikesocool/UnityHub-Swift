import SwiftUI

private struct ExpandedLabelButtonStyle<WrappedStyle>: PrimitiveButtonStyle where
	WrappedStyle: ButtonStyle
{
	private let wrappedStyle: WrappedStyle
	private let axes: Axis.Set

	public init(_ wrappedStyle: WrappedStyle, axes: Axis.Set = [.vertical, .horizontal]) {
		self.wrappedStyle = wrappedStyle
		self.axes = axes
	}

	public func makeBody(configuration: Configuration) -> some View {
		Button(role: configuration.role, action: configuration.trigger) {
			configuration.label
				.frame(
					maxWidth: axes.contains(.horizontal) ? .infinity : nil,
					maxHeight: axes.contains(.vertical) ? .infinity : nil
				)
		}
		.buttonStyle(wrappedStyle)
	}
}

private struct ExpandedLabelPrimitiveButtonStyle<WrappedStyle>: PrimitiveButtonStyle where
	WrappedStyle: PrimitiveButtonStyle
{
	private let wrappedStyle: WrappedStyle
	private let axes: Axis.Set

	public init(_ wrappedStyle: WrappedStyle, axes: Axis.Set = [.vertical, .horizontal]) {
		self.wrappedStyle = wrappedStyle
		self.axes = axes
	}

	public func makeBody(configuration: Configuration) -> some View {
		Button(role: configuration.role, action: configuration.trigger) {
			configuration.label
				.frame(
					maxWidth: axes.contains(.horizontal) ? .infinity : nil,
					maxHeight: axes.contains(.vertical) ? .infinity : nil
				)
		}
		.buttonStyle(wrappedStyle)
	}
}

// MARK: - Convenience

public extension ButtonStyle {
	/// - Parameter axes: The axes to expand the label on.
	func expandedLabel(axes: Axis.Set = [.horizontal, .vertical]) -> some PrimitiveButtonStyle {
		ExpandedLabelButtonStyle(self, axes: axes)
	}
}

public extension PrimitiveButtonStyle {
	/// - Parameter axes: The axes to expand the label on.
	func expandedLabel(axes: Axis.Set = [.horizontal, .vertical]) -> some PrimitiveButtonStyle {
		ExpandedLabelPrimitiveButtonStyle(self, axes: axes)
	}
}
