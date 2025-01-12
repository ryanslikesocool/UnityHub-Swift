import SwiftUI
import UnityHubCommonViews
import UserIcon

/// ## Topics
/// - ``UserIconEditorStyle/horizontalSheet``
struct HorizontalSheetUserIconEditorStyle: UserIconEditorStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		ContentView(configuration: configuration)
	}
}

// MARK: - Supporting Views

private struct ContentView: View {
	public typealias Configuration = UserIconEditorStyleConfiguration

	@Environment(\.dismiss) private var dismiss

	private let configuration: Configuration

	public init(configuration: Configuration) {
		self.configuration = configuration
	}

	public var body: some View {
		Sheet {
			HStack(spacing: 0) {
				makeIconPreview(view: configuration.iconPreview)

				Divider()

				makeModelEditor(view: configuration.modelEditor)
			}
		} header: {
			makeKindPicker(view: configuration.kindPicker)
				.padding([.top, .bottom], -8)

			Spacer()

			Button(
				String(localized: .common.action.done),
				role: .cancel
			) { dismiss() }
				.controlSize(.large)
		}
	}
}

private extension ContentView {
	func makeIconPreview(view: Configuration.IconPreview) -> some View {
		view
			.frame(height: Self.iconPreviewHeight)
			.padding(Self.paddingLength)
	}

	func makeKindPicker(view: Configuration.KindPicker) -> some View {
		HStack {
			view
		}
		.frame(height: Self.kindPickerHeight)
	}

	func makeModelEditor(view: Configuration.ModelEditor) -> some View {
		view
			.frame(width: Self.modelEditorWidth)
	}
}

// MARK: - Constants

private extension ContentView {
	private static let iconPreviewHeight: CGFloat = 192
	private static let kindPickerHeight: CGFloat = 32
	private static let modelEditorWidth: CGFloat = 256

	private static let paddingLength: CGFloat = 16
}

// MARK: -

extension UserIconEditorStyle where
	Self == HorizontalSheetUserIconEditorStyle
{
	static var horizontalSheet: Self {
		Self()
	}
}
