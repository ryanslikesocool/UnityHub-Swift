import SwiftUI
import UnityHubCommon

public struct SectionURLPickerStyle: URLPickerStyle {
	public typealias Configuration = URLPickerStyleConfiguration

	public func makeBody(configuration: Configuration) -> some View {
		Section(
			content: {
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
			},
			header: {
				configuration.label
			}
		)
	}
}

public extension ViewStyle<URLPickerStyleConfiguration> where Self == SectionURLPickerStyle {
	static var section: Self { Self() }
}
