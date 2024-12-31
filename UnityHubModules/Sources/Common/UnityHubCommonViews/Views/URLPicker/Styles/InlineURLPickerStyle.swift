import SwiftUI
import UnityHubCommon

public struct InlineURLPickerStyle: URLPickerStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		LabeledContent(
			content: {
				HStack {
					configuration.issueButton
						.buttonStyle(.plain)

					configuration.urlLabel
						.foregroundStyle(.secondary)

					Button(String(localized: .common.action.select), systemImage: .folder) {
						configuration.startImport()
					}
					.labelStyle(.iconOnly)
				}
			},
			label: {
				configuration.label
			}
		)
	}
}

// MARK: - Convenience

public extension URLPickerStyle where
	Self == InlineURLPickerStyle
{
	static var inline: Self {
		Self()
	}
}
