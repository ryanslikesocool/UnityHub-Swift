import Combine

// public extension PassthroughSubject where
//	Failure == Never
// {
//	func callAsFunction(_ input: Output) {
//		send(input)
//	}
// }
//
// public extension PassthroughSubject<Void, Never> {
//	func callAsFunction() {
//		send()
//	}
// }

public extension PassthroughSubject {
	func send<each Element>(_ input: repeat each Element) where
		Output == (repeat each Element)
	{
		send((repeat each input))
	}
}
