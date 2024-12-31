import SwiftUI

struct AcknowledgementList<A>: View where
	A: Acknowledgement
{
	@EnvironmentObject private var model: AboutSceneModel

	private var acknowledgements: [A] {
		model[keyPath: A.modelKeyPath]
	}

	public init(_ type: A.Type) { }

	public var body: some View {
		ForEach(acknowledgements.indices, id: \.self) { i in
			A.ItemView(acknowledgements[i])
		}
		.labelStyle(Self.labelStyle)
		.task {
			await model.loadAcknowledgement(A.self)
		}
	}
}

// MARK: - Constants

private extension AcknowledgementList {
	static var labelStyle: some LabelStyle { .iconOnly }
}
