// swift-tools-version: 5.10

import PackageDescription

let package = Package(
	name: "UnityHubStorageModules",
	defaultLocalization: "en",
	platforms: [.macOS(.v14)],
	products: [
		.library(name: "UnityHubStorage", targets: ["UnityHubStorage"]),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/UserIcon.git", branch: "main"),

		.package(path: "../UnityHubCommonModules"),
	],
	targets: [
		.target(name: "UnityHubStorage", dependencies: [
			"UnityHubProjectsStorage",
			"UnityHubInstallationsStorage",
			"UnityHubSettingsStorage",
		]),

		// MARK: - Internal

		.target(name: "UnityHubProjectsStorage", dependencies: [
			"UserIcon",

			"UnityHubInstallationsStorage",
		]),

		.target(name: "UnityHubInstallationsStorage", dependencies: [
			"UnityHubSettingsStorage",
		]),

		.target(name: "UnityHubSettingsStorage", dependencies: [
			"UnityHubStorageCommon",
		]),

		.target(name: "UnityHubStorageCommon", dependencies: [
			.product(name: "UnityHubCommon", package: "UnityHubCommonModules"),
		]),
	]
)
