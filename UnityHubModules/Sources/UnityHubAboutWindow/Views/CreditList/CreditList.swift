import SwiftUI

struct CreditList<C>: View where
	C: CreditProtocol
{
	@EnvironmentObject private var model: AboutSceneModel

	private var credits: [C] {
		model[keyPath: C.modelKeyPath]
	}

	public init(_ type: C.Type) { }

	public var body: some View {
		ForEach(credits.indices, id: \.self) { i in
			C.ItemView(credits[i])
		}
		.labelStyle(Self.labelStyle)
		.task {
			await model.loadCredit(C.self)
		}
	}
}

// MARK: - Constants

private extension CreditList {
	static var labelStyle: some LabelStyle { .iconOnly }
}
