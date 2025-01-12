import SwiftUI

struct CreditList<Item>: View where
	Item: CreditItem
{
	@EnvironmentObject private var model: AboutSceneModel

	private var credits: [Item] {
		model[keyPath: Item.modelKeyPath]
	}

	public init(ofType itemType: Item.Type) { }

	public var body: some View {
		ForEach(credits.indices, id: \.self) { i in
			Item.ItemView(credits[i])
		}
		.labeledContentStyle(Self.labeledContentStyle)
		.labelStyle(Self.labelStyle)
		.task {
			await model.loadCredits(ofType: Item.self)
		}
	}
}

// MARK: - Constants

private extension CreditList {
	static var labeledContentStyle: some LabeledContentStyle { .credit }
	static var labelStyle: some LabelStyle { .iconOnly }
}
