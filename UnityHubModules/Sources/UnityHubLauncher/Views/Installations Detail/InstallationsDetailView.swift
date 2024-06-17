import SwiftUI
import UserIcon

struct InstallationsDetailView: View {
	@State private var icon: UserIcon = .monogram

	var body: some View {
		Text("installations placeholder")

		UserIconPicker(selection: $icon, label: EmptyView.init)
			.userIconEditorStyle(.horizontalCompact)
	}
}
