import SwiftUI

public struct URLPickerStyleConfiguration {
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

	public let label: Label
	public let urlLabel: URLLabel
	public let startImport: Action

	init(
		label: some View,
		urlLabel: some View,
		startImport: @escaping Action
	) {
		self.label = Label(content: label)
		self.urlLabel = URLLabel(content: urlLabel)
		self.startImport = startImport
	}
}
