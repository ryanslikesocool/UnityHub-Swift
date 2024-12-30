// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "UnityHubModules",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(
			name: "UnityHub",
			targets: ["UnityHub"]
		),

		.library(
			name: "UnityHub - MainWindow",
			targets: [
				"UnityHubMainWindow",
				"UnityHubMainWindowProjects",
				"UnityHubMainWindowInstallations",
				"UnityHubMainWindowResources",
			]
		),

		.library(
			name: "UnityHub - Storage",
			targets: [
				"UnityHubStorageViews",
				"UnityHubStorageProjects",
				"UnityHubStorageInstallations",
				"UnityHubStorageSettings",
				"UnityHubStorageCommon",
			]
		),

		.library(
			name: "UnityHub - Common",
			targets: [
				"UnityHubCommon",
				"UnityHubCommonViews",
			]
		),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/MoreWindows.git", from: "0.1.0"),
		.package(url: "https://github.com/ryanslikesocool/UserIcon.git", branch: "main"),
	],
	targets: [
		.target(
			name: "UnityHub",
			dependencies: [
				"UnityHubMainWindow",
				"UnityHubAboutWindow",
				"UnityHubSettingsWindow",
			]
		),

		.target(
			name: "UnityHubAboutWindow",
			dependencies: [
				"MoreWindows",

				"UnityHubCommon",
				"UnityHubCommonViews",
			]
		),

		.target(
			name: "UnityHubSettingsWindow",
			dependencies: [
				"UnityHubOfficialCLI",
				"UnityHubStorageSettings",
				"UnityHubCommon",
				"UnityHubCommonViews",
			]
		),

		.target(
			name: "UnityHubOfficialCLI",
			dependencies: [
				"UnityHubCommon",
				"UnityHubStorageSettings",
				"UnityHubStorageInstallations",
			]
		),
	]
		+ mainWindowTargets
		+ storageTargets
		+ commonTargets
)

// MARK: - Target Groups

var mainWindowTargets: [Target] {
	[
		.target(
			name: "UnityHubMainWindow",
			dependencies: [
				"UnityHubMainWindowProjects",
				"UnityHubMainWindowInstallations",
				"UnityHubMainWindowResources",
			]
		),

		.target(
			name: "UnityHubMainWindowResources",
			dependencies: [
				"UnityHubCommon",
				"UnityHubCommonViews",
			]
		),

		.target(
			name: "UnityHubMainWindowInstallations",
			dependencies: [
				"UnityHubStorageCommon",
				"UnityHubStorageViews",
				"UnityHubStorageSettings",
				"UnityHubStorageInstallations",
				"UnityHubCommon",
				"UnityHubCommonViews",
			]
		),

		.target(
			name: "UnityHubMainWindowProjects",
			dependencies: [
				"UserIcon",

				"UnityHubCommon",
				"UnityHubCommonViews",
				"UnityHubStorageCommon",
				"UnityHubStorageViews",
				"UnityHubStorageSettings",
				"UnityHubStorageProjects",
				"UnityHubStorageInstallations",
			]
		),
	]
	.formatPaths(using: "Sources/MainWindow/%@")
}

var storageTargets: [Target] {
	[
		.target(
			name: "UnityHubStorageViews",
			dependencies: [
				"UnityHubCommonViews",
				"UnityHubStorageInstallations",
			]
		),

		.target(
			name: "UnityHubStorageProjects",
			dependencies: [
				"UserIcon",

				"UnityHubStorageInstallations",
			]
		),

		.target(
			name: "UnityHubStorageInstallations",
			dependencies: [
				"UnityHubStorageSettings",
			]
		),

		.target(
			name: "UnityHubStorageSettings",
			dependencies: [
				"UnityHubStorageCommon",
			]
		),

		.target(
			name: "UnityHubStorageCommon",
			dependencies: [
				"UnityHubCommon",
			]
		),
	]
	.formatPaths(using: "Sources/Storage/%@")
}

var commonTargets: [Target] {
	[
		.target(
			name: "UnityHubCommonViews",
			dependencies: [
				"MoreWindows",

				"UnityHubCommon",
			]
		),

		.target(name: "UnityHubCommon"),
	]
	.formatPaths(using: "Sources/Common/%@")
}

// MARK: - Utility

extension [Target] {
	func formatPaths(using format: String) -> Self {
		map { target in
			target.formatPath(using: format)
			return target
		}
	}
}

extension Target {
	func formatPath(using format: String) {
		path = String(format: format, path ?? name)
	}
}
