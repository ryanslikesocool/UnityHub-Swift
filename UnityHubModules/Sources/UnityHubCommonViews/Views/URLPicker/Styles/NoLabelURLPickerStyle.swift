import SwiftUI
import UnityHubCommon

public struct NoLabelURLPickerStyle: URLPickerStyle {
	public typealias Configuration = URLPickerStyleConfiguration

	public func makeBody(configuration: Configuration) -> some View {
		LabeledContent(
			content: {
				Button("Select", systemImage: Constant.Symbol.folder, action: configuration.startImport)
			},
			label: {
				HStack {
					configuration.issueButton
						.buttonStyle(.plain)
					
					configuration.urlLabel
						.foregroundStyle(.secondary)
				}
			}
		)
	}
}

public extension ViewStyle<URLPickerStyleConfiguration> where Self == NoLabelURLPickerStyle {
	static var noLabel: Self { Self() }
}
