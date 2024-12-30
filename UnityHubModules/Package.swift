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
				"UnityHubInclude",
			]
		),

		.target(
			name: "UnityHubSettings",
			dependencies: [
				"UnityHubInclude",
				"UnityHubOfficialCLI",
			]
		),

		// MARK: - Detail

		.target(
			name: "UnityHubResources",
			dependencies: [
				"UnityHubInclude",
			]
		),

		.target(
			name: "UnityHubInstallations",
			dependencies: [
				"UnityHubInclude",
			]
		),

		.target(
			name: "UnityHubProjects",
			dependencies: [
				"UnityHubInclude",
			]
		),

		// MARK: - Common

		.target(
			name: "UnityHubOfficialCLI",
			dependencies: [
				"UnityHubInclude",
			]
		),

		.target(
			name: "UnityHubInclude",
			dependencies: [
				"MoreWindows",
				"UserIcon",

				"UnityHubCommon",
				"UnityHubCommonViews",
				"UnityHubStorageViews",
				"UnityHubStorageProjects",
				"UnityHubStorageInstallations",
				"UnityHubStorageSettings",
				"UnityHubStorageCommon",
			]
		),
	]
		+ storageTargets
		+ commonTargets
)

// MARK: - Target Groups

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
