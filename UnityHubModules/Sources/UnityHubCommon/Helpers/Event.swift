import Combine

public enum Event {
	public typealias Passthrough<each Argument> = PassthroughSubject<(repeat each Argument), Never>
}
