import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

struct AcknowledgementsList: View {
	@EnvironmentObject private var model: AboutSceneModel

	public init() { }

	public var body: some View {
		List {
			ForEach(model.acknowledgements.indices, id: \.self) { i in
				let acknowledgement = model.acknowledgements[i]
				RealLink(acknowledgement.title, destination: acknowledgement.url)
			}
		}
		.task {
			model.loadAcknowledgements()
		}
	}
}
