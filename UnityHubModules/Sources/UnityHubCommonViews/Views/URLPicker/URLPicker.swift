import MoreWindows
import OSLog
import SwiftUI
import UniformTypeIdentifiers
import UnityHubCommon

public struct URLPicker<Label: View>: View {
	public typealias LabelProvider = () -> Label
	public typealias ValidationFunction = (URL) throws -> Void

	@Environment(\.urlPickerStyle) private var style
	@Environment(\.windowID) private var windowID

	@State private var isPresentingDialog: Bool = false
	@State private var issue: LocalizedError? = nil

	@Binding private var selection: URL
	private let label: LabelProvider
	private let allowedContentTypes: [UTType]
	private let validator: ValidationFunction?

	public init(
		selection: Binding<URL>,
		allowedContentTypes: [UTType],
		validator: ValidationFunction? = nil,
		@ViewBuilder label: @escaping LabelProvider
	) {
		_selection = selection
		self.label = label
		self.allowedContentTypes = allowedContentTypes
		self.validator = validator
	}

	public var body: some View {
		style.makeBody(configuration: _AnyURLPickerStyle.Configuration(
			label: label(),
			urlLabel: URLLabel(selection)
				.contextMenu {
					Button.showInFinder(destination: selection)
						.labelStyle(.titleAndIcon)
				},
			issueButton: issueButton,
			startImport: { isPresentingDialog = true }
		))
		.fileImporter(
			isPresented: $isPresentingDialog,
			allowedContentTypes: allowedContentTypes,
			onCompletion: onFileImportComplete
		)
		.onAppear(perform: onValidate)
		.onChange(of: selection, onValidate)
	}
}

// MARK: - Supporting Views

private extension URLPicker {
	@ViewBuilder var issueButton: some View {
		if
			let issue,
			let windowID
		{
			Button(action: {
				switch issue {
					case let issue as LocationError: Event.locationError((windowID, issue))
					case let issue as ApplicationError: Event.applicationError((windowID, issue))
					default: preconditionFailure(unexpectedError: issue)
				}
			}, label: SwiftUI.Label.issue)
		}
	}
}

// MARK: - Functions

private extension URLPicker {
	func onValidate() {
		guard let validator else {
			return
		}

		DispatchQueue.main.async {
			do {
				try validator(selection)
				issue = nil
			} catch let error as LocalizedError {
				issue = error
			} catch {
				preconditionFailure(unexpectedError: error)
			}
		}
	}

	func onFileImportComplete(result: Result<URL, Error>) {
		switch result {
			case let .failure(error):
				Logger.module.error("""
				Failed to select URL:
				\(error.localizedDescription)
				""")
			case let .success(url):
				selection = url
		}
	}
}

// MARK: - Init+

public extension URLPicker {
	init(
		selection: Binding<URL?>,
		defaultValue: URL,
		allowedContentTypes: [UTType],
		validator: ValidationFunction? = nil,
		@ViewBuilder label: @escaping LabelProvider
	) {
		self.init(
			selection: Binding<URL>(selection, defaultValue: defaultValue),
			allowedContentTypes: allowedContentTypes,
			validator: validator,
			label: label
		)
	}
}

public extension URLPicker
	where Label == Text
{
	init(
		_ title: some StringProtocol,
		selection: Binding<URL>,
		allowedContentTypes: [UTType],
		validator: ValidationFunction? = nil
	) {
		self.init(selection: selection, allowedContentTypes: allowedContentTypes, validator: validator, label: { Text(title) })
	}

	init(
		_ titleKey: LocalizedStringKey,
		selection: Binding<URL>,
		allowedContentTypes: [UTType],
		validator: ValidationFunction? = nil
	) {
		self.init(selection: selection, allowedContentTypes: allowedContentTypes, validator: validator, label: { Text(titleKey) })
	}

	init(
		_ title: some StringProtocol,
		selection: Binding<URL?>,
		defaultValue: URL,
		allowedContentTypes: [UTType],
		validator: ValidationFunction? = nil
	) {
		self.init(selection: selection, defaultValue: defaultValue, allowedContentTypes: allowedContentTypes, validator: validator, label: { Text(title) })
	}

	init(
		_ titleKey: LocalizedStringKey,
		selection: Binding<URL?>,
		defaultValue: URL,
		allowedContentTypes: [UTType],
		validator: ValidationFunction? = nil
	) {
		self.init(selection: selection, defaultValue: defaultValue, allowedContentTypes: allowedContentTypes, validator: validator, label: { Text(titleKey) })
	}
}
