// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "UnityHubModules",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14)
	],
	products: [
		.library(name: "UnityHub", targets: ["UnityHub"]),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/MoreWindows.git", from: "0.1.0"),
		.package(url: "https://github.com/ryanslikesocool/UserIcon.git", branch: "main"),

		.package(path: "../UnityHubCommonModules"),
		.package(path: "../UnityHubStorageModules"),
	],
	targets: [
		.target(name: "UnityHub", dependencies: [
			"UnityHubMain",
			"UnityHubAbout",
			"UnityHubSettings",
		]),

		.target(name: "UnityHubMain", dependencies: [
			"UnityHubProjects",
			"UnityHubInstallations",
			"UnityHubResources",
		]),

		.target(name: "UnityHubAbout", dependencies: [
			"UnityHubInclude",
		]),

		.target(name: "UnityHubSettings", dependencies: [
			"UnityHubInclude",
			"UnityHubOfficialCLI",
		]),

		// MARK: - Detail

		.target(name: "UnityHubResources", dependencies: [
			"UnityHubInclude",
		]),

		.target(name: "UnityHubInstallations", dependencies: [
			"UnityHubInclude",
		]),

		.target(name: "UnityHubProjects", dependencies: [
			"UnityHubInclude",
		]),

		// MARK: - Common

		.target(name: "UnityHubOfficialCLI", dependencies: [
			"UnityHubInclude",
		]),

		.target(name: "UnityHubInclude", dependencies: [
			"MoreWindows",
			"UserIcon",
			.product(name: "UnityHubCore", package: "UnityHubCommonModules"),
			.product(name: "UnityHubCommon", package: "UnityHubCommonModules"),
			.product(name: "UnityHubCommonViews", package: "UnityHubCommonModules"),
			.product(name: "UnityHubStorage", package: "UnityHubStorageModules"),
		]),
	]
)
