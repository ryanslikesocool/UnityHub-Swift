// swift-tools-version: 5.10

import PackageDescription

let package = Package(
	name: "UnityHubStorageModules",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14)
	],
	products: [
		.library(name: "UnityHubStorage", targets: ["UnityHubStorage"]),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/UserIcon.git", branch: "main"),

		.package(path: "../UnityHubCommonModules"),
	],
	targets: [
		.target(name: "UnityHubStorage", dependencies: [
			"UHStorage_Projects",
			"UHStorage_Installations",
			"UHStorage_Settings",
		]),

		// MARK: - Internal

		.target(name: "UHStorage_Projects", dependencies: [
			"UserIcon",

			"UHStorage_Installations",
		]),

		.target(name: "UHStorage_Installations", dependencies: [
			"UHStorage_Settings",
		]),

		.target(name: "UHStorage_Settings", dependencies: [
			"UHStorage_Common",
		]),

		.target(name: "UHStorage_Common", dependencies: [
			.product(name: "UnityHubCommon", package: "UnityHubCommonModules"),
		]),
	]
)
