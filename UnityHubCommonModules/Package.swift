// swift-tools-version: 5.10

import CompilerPluginSupport
import PackageDescription

let package = Package(
	name: "UnityHubCommonModules",
	defaultLocalization: "en",
	platforms: [.macOS(.v14)],
	products: [
		.library(
			name: "UnityHubCommon",
			targets: ["UnityHubCommon"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-syntax.git", from: "510.0.1"),
	],
	targets: [
		.target(
			name: "UnityHubCommon",
			dependencies: [
				"UnityHubMacros",
			]
		),

		// MARK: - Macros

		.macro(
			name: "UnityHubMacros",
			dependencies: [
				.product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
				.product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
			]
		),

		// MARK: - Tests

		.testTarget(
			name: "UnityHubMacrosTests",
			dependencies: [
				"UnityHubMacros",
				.product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
			]
		),
	]
)
