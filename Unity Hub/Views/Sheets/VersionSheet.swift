//
//  VersionSheet.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 11/15/20.
//

import SwiftUI

struct VersionSheet: View {
	@Binding var selectedVersion: UnityVersion
	@Binding var availableVersions: [UnityVersion]

	var body: some View {
		ScrollView {
			Picker("", selection: $selectedVersion) {
				ForEach(availableVersions, id: \.self) { version in
					HStack {
						Text(version.version)
						PrereleaseTag(version: version, small: true)
						Spacer()
					}
					.tag(version)
					.frame(height: 24)
				}
			}
			.padding(.vertical)
			.pickerStyle(.radioGroup)
		}
		.frame(width: 200)
		.frame(minHeight: 200)
		.tabItem { Text("Version") }
		.tag("Version")
	}
}
