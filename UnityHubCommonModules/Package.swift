// swift-tools-version: 6.0

import CompilerPluginSupport
import PackageDescription

let package = Package(
	name: "UnityHubCommonModules",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(name: "UnityHubCore", targets: ["UnityHubCore"]),
		.library(name: "UnityHubCommon", targets: ["UnityHubCommon"]),
		.library(name: "UnityHubCommonViews", targets: ["UnityHubCommonViews"]),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/MoreWindows.git", branch: "main"),
	],
	targets: [
		.target(name: "UnityHubCommonViews", dependencies: [
			"MoreWindows",

			"UnityHubCommon",
			"UnityHubCore",
		]),

		.target(name: "UnityHubCommon", dependencies: [
			"UnityHubCore",
		]),

		.target(name: "UnityHubCore"),
	]
)
