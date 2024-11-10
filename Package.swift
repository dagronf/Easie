// swift-tools-version: 5.4

import PackageDescription

#if canImport(CoreGraphics)
let deps: [PackageDescription.Package.Dependency] = [
	.package(url: "https://github.com/dagronf/Bitmap", from: "1.4.0")
]
let testDeps: [PackageDescription.Target.Dependency] = ["EasingFunctionsKit", "Bitmap"]
#else
let deps: [PackageDescription.Package.Dependency] = []
let testDeps: [PackageDescription.Target.Dependency] = ["EasingFunctionsKit"]
#endif

let package = Package(
	name: "EasingFunctionsKit",
	products: [
		.library(
			name: "EasingFunctionsKit",
			targets: ["EasingFunctionsKit"]),
	],
	dependencies: deps,
	targets: [
		.target(
			name: "EasingFunctionsKit"),
		.testTarget(
			name: "EasingFunctionsKitTests",
			dependencies: testDeps
		),
	]
)
