import SwiftUI
import UnityHubSettingsStorage

struct ProjectInfoVisibilityMenu: View {
	@Binding var selection: ProjectInfoVisibility.Mask

	var body: some View {
		Menu("Visibility", systemImage: "eye") {
			Toggle("Icon", isOn: makeBinding(for: .icon))
			Toggle("Last Opened", isOn: makeBinding(for: .lastOpened))
			Toggle("Location", isOn: makeBinding(for: .location))
			Toggle("Editor Version", isOn: makeBinding(for: .editorVersion))
		}
	}
}

// MARK: - Functions

private extension ProjectInfoVisibilityMenu {
	func makeBinding(for item: ProjectInfoVisibility) -> Binding<Bool> {
		let mask = ProjectInfoVisibility.Mask(item)
		return Binding<Bool>(
			get: { selection.contains(mask) },
			set: { newValue in
				if newValue {
					selection.insert(mask)
				} else {
					selection.remove(mask)
				}
			}
		)
	}
}
