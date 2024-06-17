// swift-tools-version: 5.10

import PackageDescription

let package = Package(
	name: "UnityHubModules",
	defaultLocalization: "en",
	platforms: [.macOS(.v14)],
	products: [
		.library(
			name: "UnityHub",
			targets: ["UnityHub"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/MoreWindows.git", from: "0.1.0"),
		.package(url: "https://github.com/ryanslikesocool/SerializationKit.git", branch: "main"),
		.package(url: "https://github.com/ryanslikesocool/UserIcon.git", branch: "main"),
	],
	targets: [
		.target(
			name: "UnityHub",
			dependencies: [
				"UnityHubScene",
				"UnityHubAbout",
				"UnityHubSettings",
			]
		),

		.target(
			name: "UnityHubScene",
			dependencies: [
				"UnityHubProjects",
			]
		),

		.target(
			name: "UnityHubAbout",
			dependencies: [
				"UnityHubCommon",
			]
		),

		.target(
			name: "UnityHubSettings",
			dependencies: [
				"UnityHubSettingsStorage",
			]
		),

		// MARK: - Detail

		.target(
			name: "UnityHubProjects",
			dependencies: [
				"UnityHubCommon",
				"UnityHubProjectStorage",
			]
		),

		// MARK: - Storage

		.target(
			name: "UnityHubProjectStorage",
			dependencies: [
				"UnityHubSettingsStorage",
			]
		),

		.target(
			name: "UnityHubSettingsStorage",
			dependencies: [
				"UnityHubCommon",
			]
		),

		// MARK: - Common

		.target(
			name: "UnityHubCommon",
			dependencies: [
				"SerializationKit",
				"MoreWindows",
				"UserIcon",
			]
		),
	]
)
