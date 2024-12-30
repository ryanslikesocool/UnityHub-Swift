import SwiftUI
import UnityHubCommon

public struct NoLabelURLPickerStyle: URLPickerStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		LabeledContent {
			Button("Select", systemImage: .folder) {
				configuration.startImport()
			}
		} label: {
			HStack {
				configuration.issueButton
					.buttonStyle(.plain)

				configuration.urlLabel
					.foregroundStyle(.secondary)
			}
		}
	}
}

// MARK: - Convenience

public extension URLPickerStyle where
	Self == NoLabelURLPickerStyle
{
	static var noLabel: Self {
		Self()
	}
}
