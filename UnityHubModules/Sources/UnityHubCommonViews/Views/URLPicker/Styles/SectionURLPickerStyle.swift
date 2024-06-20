import SwiftUI
import UnityHubCommon

public struct SectionURLPickerStyle: URLPickerStyle {
	public func makeBody(configuration: Configuration) -> some View {
		Section(
			content: {
				LabeledContent(
					content: {
						Button("Select", systemImage: Constant.Symbol.folder, action: configuration.startImport)
					},
					label: {
						configuration.urlLabel
							.foregroundStyle(.secondary)
					}
				)
			},
			header: {
				configuration.label
			}
		)
	}
}

public extension URLPickerStyle where Self == SectionURLPickerStyle {
	static var section: Self { Self() }
}
