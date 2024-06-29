import SwiftUI

public struct URLPickerStyleConfiguration: ViewStyleConfiguration {
	public typealias Action = () -> Void

	/// The type-erased label of a ``URLPicker``.
	public struct Label: View {
		init(content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}

	/// The type-erased URL label of a ``URLPicker``.
	public struct URLLabel: View {
		init(content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}

	/// The type-erased issue button of a ``URLPicker``.
	public struct IssueButton: View {
		init(content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}

	public let label: Label
	public let urlLabel: URLLabel
	public let issueButton: IssueButton
	public let startImport: Action

	init(
		label: some View,
		urlLabel: some View,
		issueButton: some View,
		startImport: @escaping Action
	) {
		self.label = Label(content: label)
		self.urlLabel = URLLabel(content: urlLabel)
		self.issueButton = IssueButton(content: issueButton)
		self.startImport = startImport
	}
}
