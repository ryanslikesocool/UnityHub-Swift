import SwiftUI
import UnityHubCommonViews
import UserIcon

struct HorizontalSheetUserIconEditorStyle: UserIconEditorStyle {
	func makeBody(configuration: Configuration) -> some View {
		let dismiss = configuration.environmentValues.dismiss

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

			Button("Done", role: .cancel) { dismiss() }
				.controlSize(.large)
		}
	}
}

// MARK: - Supporting Views

private extension HorizontalSheetUserIconEditorStyle {
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

private extension HorizontalSheetUserIconEditorStyle {
	private static let iconPreviewHeight: CGFloat = 192
	private static let kindPickerHeight: CGFloat = 32
	private static let modelEditorWidth: CGFloat = 256

	private static let paddingLength: CGFloat = 16
}

// MARK: -

extension UserIconEditorStyle where Self == HorizontalSheetUserIconEditorStyle {
	static var horizontalSheet: Self { Self() }
}
