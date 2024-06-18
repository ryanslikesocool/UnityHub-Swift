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
				"UnityHubMain",
				"UnityHubAbout",
				"UnityHubSettings",
			]
		),

		.target(
			name: "UnityHubMain",
			dependencies: [
				"UnityHubProjects",
				"UnityHubInstallations",
				"UnityHubResources",
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
				"UnityHubStorage",
			]
		),

		// MARK: - Detail

		.target(
			name: "UnityHubResources",
			dependencies: [
				"UnityHubCommonViews",
			]
		),

		.target(
			name: "UnityHubInstallations",
			dependencies: [
				"UnityHubCommonViews",
			]
		),

		.target(
			name: "UnityHubProjects",
			dependencies: [
				"UnityHubCommonViews",
			]
		),

		// MARK: -

		.target(
			name: "UnityHubCommonViews",
			dependencies: [
				"UnityHubCommon",
				"UnityHubStorage",
			]
		),

		// MARK: - Storage

		.target(
			name: "UnityHubStorage",
			dependencies: [
				"UnityHubProjectStorage",
			]
		),

		.target(
			name: "UnityHubProjectStorage",
			dependencies: [
				"UnityHubInstallationsStorage",
			]
		),

		.target(
			name: "UnityHubInstallationsStorage",
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
