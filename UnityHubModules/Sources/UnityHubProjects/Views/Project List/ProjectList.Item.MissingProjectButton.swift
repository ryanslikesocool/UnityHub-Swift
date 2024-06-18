import SwiftUI
import UnityHubCommon
import OSLog
import UnityHubStorage

extension ProjectList.Item {
	struct MissingIcon: View {
		@State private var isPresentingAlert: Bool = false

		@Binding private var project: ProjectMetadata

		init(_ project: Binding<ProjectMetadata>) {
			_project = project
		}

		var body: some View {
			Button(action: { isPresentingAlert = true }) {
				Image(systemName: "exclamationmark.triangle.fill")
					.symbolEffect(.pulse.wholeSymbol, options: .repeating)
					.symbolRenderingMode(.monochrome)
					.font(.title2)
					.frame(width: Icon.size - 16, height: Icon.size - 4)
			}
			.tint(.yellow)
			.buttonStyle(.borderedProminent)
			.controlSize(.large)
			
			.confirmationDialog(
				"Missing Project",
				isPresented: $isPresentingAlert,
				actions: {
					Button("Remove", systemImage: "trash", role: .cancel) {
						Event.removeProject(project.url)
					}

					Button("Locate", systemImage: "folder") {
						Event.importProject(.replace(project))
					}
				},
				message: {
					Text("The project \"\(project.name)\" cannot be found.")
				}
			)
			.dialogSeverity(.critical)
		}
	}
}
