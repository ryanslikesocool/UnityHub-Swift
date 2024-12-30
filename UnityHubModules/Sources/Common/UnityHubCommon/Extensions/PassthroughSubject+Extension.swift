import Combine

public extension PassthroughSubject {
	func send<each Element>(_ input: repeat each Element) where
		Output == (repeat each Element)
	{
		send((repeat each input))
	}
}
