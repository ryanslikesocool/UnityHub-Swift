import OSLog
import SwiftUI
import UniformTypeIdentifiers

public struct URLPicker<Label: View>: View {
	public typealias LabelProvider = () -> Label

	@Environment(\.urlPickerStyle) private var style

	@State private var isPresentingDialog: Bool = false

	@Binding private var selection: URL
	private let label: LabelProvider
	private let allowedContentTypes: [UTType]

	public init(
		selection: Binding<URL>,
		allowedContentTypes: [UTType],
		@ViewBuilder label: @escaping LabelProvider
	) {
		_selection = selection
		self.label = label
		self.allowedContentTypes = allowedContentTypes
	}

	public var body: some View {
		style.makeBody(configuration: _AnyURLPickerStyle.Configuration(
			label: label(),
			urlLabel: URLLabel(selection)
				.contextMenu {
					Button.showInFinder(destination: selection)
						.labelStyle(.titleAndIcon)
				},
			startImport: { isPresentingDialog = true }
		))
		.fileImporter(
			isPresented: $isPresentingDialog,
			allowedContentTypes: allowedContentTypes,
			onCompletion: onFileImportComplete
		)
	}
}

// MARK: - Functions

private extension URLPicker {
	func onFileImportComplete(result: Result<URL, Error>) {
		switch result {
			case let .failure(error):
				Logger.module.error("""
				Failed to select URL:
				\(error.localizedDescription)
				""")
			case let .success(url): selection = url
		}
	}
}

// MARK: - Init+

public extension URLPicker {
	init(
		selection: Binding<URL?>,
		defaultValue: URL,
		allowedContentTypes: [UTType],
		@ViewBuilder label: @escaping LabelProvider
	) {
		let binding = Binding<URL>(
			get: { selection.wrappedValue ?? defaultValue },
			set: { newValue in
				selection.wrappedValue = if newValue == defaultValue {
					nil
				} else {
					newValue
				}
			}
		)
		self.init(selection: binding, allowedContentTypes: allowedContentTypes, label: label)
	}
}

public extension URLPicker
	where Label == Text
{
	init(
		_ title: some StringProtocol,
		selection: Binding<URL>,
		allowedContentTypes: [UTType]
	) {
		self.init(selection: selection, allowedContentTypes: allowedContentTypes, label: { Text(title) })
	}

	init(
		_ titleKey: LocalizedStringKey,
		selection: Binding<URL>,
		allowedContentTypes: [UTType]
	) {
		self.init(selection: selection, allowedContentTypes: allowedContentTypes, label: { Text(titleKey) })
	}

	init(
		_ title: some StringProtocol,
		selection: Binding<URL?>,
		defaultValue: URL,
		allowedContentTypes: [UTType]
	) {
		self.init(selection: selection, defaultValue: defaultValue, allowedContentTypes: allowedContentTypes, label: { Text(title) })
	}

	init(
		_ titleKey: LocalizedStringKey,
		selection: Binding<URL?>,
		defaultValue: URL,
		allowedContentTypes: [UTType]
	) {
		self.init(selection: selection, defaultValue: defaultValue, allowedContentTypes: allowedContentTypes, label: { Text(titleKey) })
	}
}
