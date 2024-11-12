// swift-tools-version: 5.4

import PackageDescription

#if canImport(CoreGraphics)
let deps: [PackageDescription.Package.Dependency] = [
	.package(url: "https://github.com/dagronf/Bitmap", from: "1.4.0")
]
let testDeps: [PackageDescription.Target.Dependency] = ["Easie", "Bitmap"]
#else
let deps: [PackageDescription.Package.Dependency] = []
let testDeps: [PackageDescription.Target.Dependency] = ["Easie"]
#endif

let package = Package(
	name: "Easie",
	products: [
		.library(name: "Easie", targets: ["Easie"]),
	],
	dependencies: deps,
	targets: [
		.target(name: "Easie"),
		.testTarget(
			name: "EasieTests",
			dependencies: testDeps,
			resources: [
				.process("resources"),
			]
		),
	]
)
