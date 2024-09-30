// swift-tools-version: 5.10

import CompilerPluginSupport
import PackageDescription

let package = Package(
	name: "UnityHubCommonModules",
	defaultLocalization: "en",
	platforms: [.macOS(.v14)],
	products: [
		.library(name: "UnityHubCommon", targets: ["UnityHubCommon"]),
	],
	targets: [
		.target(name: "UnityHubCommon"),
	]
)
