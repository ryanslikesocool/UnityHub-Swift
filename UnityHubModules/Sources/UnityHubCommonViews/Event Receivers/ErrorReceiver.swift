import MoreWindows
import SwiftUI
import UnityHubCommon

public struct ErrorReceiver<ErrorType: LocalizedError, Actions: View>: View {
	public typealias EventType = Event.Passthrough<WindowID, ErrorType>
	public typealias ActionsProvider = (ErrorType) -> Actions

	@Environment(\.windowID) private var windowID

	@State private var isPresentingAlert: Bool = false
	@State private var error: ErrorType? = nil

	private let event: EventType
	private let actions: ActionsProvider

	public init(
		event: EventType,
		@ViewBuilder actions: @escaping ActionsProvider
	) {
		self.event = event
		self.actions = actions
	}

	public var body: some View {
		EmptyView()
			.onReceive(event, perform: receiveEvent)
			.alert(
				isPresented: $isPresentingAlert,
				error: error,
				actions: actions,
				message: { error in
					if let reason = error.failureReason {
						Text(reason)
					}
					if let recovery = error.recoverySuggestion {
						Text(recovery)
					}
				}
			)
			.dialogSeverity(.critical)
	}
}

// MARK: - Functions

private extension ErrorReceiver {
	func receiveEvent(windowID: WindowID, error: ErrorType) {
		guard windowID == self.windowID else {
			return
		}

		self.error = error
		isPresentingAlert = true
	}
}

// MARK: - Init+

public extension ErrorReceiver where Actions == EmptyView {
	init(event: EventType) {
		self.init(event: event, actions: { _ in })
	}
}

// MARK: - View+

public extension View {
	func errorReceiver<ErrorType: LocalizedError, Actions: View>(
		event: Event.Passthrough<WindowID, ErrorType>,
		@ViewBuilder actions: @escaping (ErrorType) -> Actions
	) -> some View {
		background { ErrorReceiver(event: event, actions: actions) }
	}

	func errorReceiver<ErrorType: LocalizedError>(
		event: Event.Passthrough<WindowID, ErrorType>
	) -> some View {
		errorReceiver(event: event, actions: { _ in })
	}
}
