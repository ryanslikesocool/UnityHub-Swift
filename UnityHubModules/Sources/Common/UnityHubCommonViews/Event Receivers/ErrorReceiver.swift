import MoreWindows
import SwiftUI
import Combine

public struct ErrorReceiver<Failure: LocalizedError, Actions: View>: View {
	public typealias EventType = PassthroughSubject<(WindowID, Failure), Never>
	public typealias ActionsProvider = (Failure) -> Actions

	@Environment(\.windowID) private var windowID

	@State private var isPresentingAlert: Bool = false
	@State private var error: Failure? = nil

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
	func receiveEvent(windowID: WindowID, error: Failure) {
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
	func errorReceiver<Failure: LocalizedError, Actions: View>(
		event: PassthroughSubject<(WindowID, Failure), Never>,
		@ViewBuilder actions: @escaping (Failure) -> Actions
	) -> some View {
		background { ErrorReceiver(event: event, actions: actions) }
	}

	func errorReceiver<Failure: LocalizedError>(
		event: PassthroughSubject<(WindowID, Failure), Never>
	) -> some View {
		errorReceiver(event: event, actions: { _ in })
	}
}
