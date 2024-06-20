import SwiftUI
import UnityHubCommon

public struct InlineURLPickerStyle: URLPickerStyle {
	public func makeBody(configuration: Configuration) -> some View {
		LabeledContent(
			content: {
				HStack {
					configuration.urlLabel
						.foregroundStyle(.secondary)
					Button("Select", systemImage: Constant.Symbol.folder, action: configuration.startImport)
						.labelStyle(.iconOnly)
				}
			},
			label: {
				configuration.label
			}
		)
	}
}

public extension URLPickerStyle where Self == InlineURLPickerStyle {
	static var inline: Self { Self() }
}
