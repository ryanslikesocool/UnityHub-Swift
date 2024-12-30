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
			name: "UnityHubStorage",
			targets: [
				"UnityHubStorageViews",
				"UnityHubStorageProjects",
				"UnityHubStorageInstallations",
				"UnityHubStorageSettings",
				"UnityHubStorageCommon",
			]
		),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/MoreWindows.git", from: "0.1.0"),
		.package(url: "https://github.com/ryanslikesocool/UserIcon.git", branch: "main"),

		.package(path: "../UnityHubCommonModules"),
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
				.product(name: "UnityHubCore", package: "UnityHubCommonModules"),
				.product(name: "UnityHubCommon", package: "UnityHubCommonModules"),
				.product(name: "UnityHubCommonViews", package: "UnityHubCommonModules"),

				"UnityHubStorageViews",
				"UnityHubStorageProjects",
				"UnityHubStorageInstallations",
				"UnityHubStorageSettings",
				"UnityHubStorageCommon",
			]
		),
	]
		+ storageTargets
)

// MARK: - Target Groups

var storageTargets: [Target] {
	[
		.target(
			name: "UnityHubStorageViews",
			dependencies: [
				.product(name: "UnityHubCommonViews", package: "UnityHubCommonModules"),

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
				.product(name: "UnityHubCommon", package: "UnityHubCommonModules"),
			]
		),
	]
	.formatPaths(using: "Sources/Storage/%@")
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
