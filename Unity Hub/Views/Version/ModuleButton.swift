//
//  LargeModule.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/4/21.
//

import SwiftUI

struct ModuleButton: View {
	@EnvironmentObject var settings: AppState

	let version: UnityVersion
	@Binding var module: ModuleJSON
	let deleteAction: (ModuleJSON) -> Void

	var sizeEmpty: Bool { return module.fileSize == "" || module.fileSize == nil }
	var sizeLoading: Bool { return module.fileSize == "." }

	var body: some View {
		HStack {
			if let icon = module.module.getIcon() {
				icon
					.frame(width: 20, height: 20)
			}
			if let name = module.module.getDisplayName() {
				Text(name)
			}
			Spacer()
			if settings.hub.showFileSize {
				let sizeBinding = Binding(get: { module.fileSize ?? "" }, set: { module.fileSize = $0 })

				LoadingText(text: sizeBinding)
					.padding(.trailing, 8)
			}

			Menu { dropDownMenu() } label: {}
				.labelsHidden()
				.menuStyle(BorderlessButtonMenuStyle())
				.frame(width: 16)
				.padding(.trailing, 40)
		}
		.padding(.leading, 32)
		.frame(height: .smallListItemHeight)
		.contentShape(Rectangle())
		.onAppear {
			if settings.hub.showFileSize, sizeEmpty {
				getModuleSize()
			}
		}
		.onChange(of: settings.hub.showFileSize, perform: { toggle in
			if toggle, sizeEmpty {
				getModuleSize()
			}
		})
		.onDisappear {
			if sizeLoading {
				module.fileSize = ""
			}
		}
		/*.swipeActions(edge: .trailing, allowsFullSwipe: false) {
			Button("􀈒 Uninstall") {
				deleteAction(module)
			}
			.tint(.red)
		}*/ // doesn't work because VersionButton's menu overrides it
		// .contextMenu { dropDownMenu() } // doesn't work because VersionButton's menu overrides it
	}

	func dropDownMenu() -> some View {
		Group {
			Button("􀈖 Reveal in Finder") { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: "\(version.path)\(module.path!)") }
			Divider()
			Button("􀈒 Uninstall Module") { deleteAction(module) }
		}
	}

	func getModuleSize() {
		if let path = module.path {
			module.fileSize = "."
			DispatchQueue.global(qos: .background).async {
				let url = URL(fileURLWithPath: "\(version.path)\(path)")
				var size = ""
				do {
					size = try url.sizeOnDisk() ?? ""
				} catch {
					print(error.localizedDescription)
				}

				DispatchQueue.main.async {
					module.fileSize = size
				}
			}
		}
	}
}
