import SwiftUI

public struct URLPickerStyleConfiguration {
	public let label: Label
	public let urlLabel: URLLabel
	public let issueButton: IssueButton
	public let startImport: () -> Void

	@MainActor
	init(
		label: some View,
		urlLabel: some View,
		issueButton: some View,
		startImport: @escaping () -> Void
	) {
		self.label = Label(label)
		self.urlLabel = URLLabel(urlLabel)
		self.issueButton = IssueButton(issueButton)
		self.startImport = startImport
	}
}

// MARK: - Supporting Data

public extension URLPickerStyleConfiguration {
	/// The type-erased label of a ``URLPicker``.
	struct Label: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}

	/// The type-erased URL label of a ``URLPicker``.
	struct URLLabel: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}

	/// The type-erased issue button of a ``URLPicker``.
	struct IssueButton: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}
}
