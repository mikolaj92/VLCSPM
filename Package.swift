// swift-tools-version: 5.6
import PackageDescription

let package = Package(
	name: "VLCSPM",
	products: [
		.library(
			name: "VLCSPM",
			targets: ["VLCSPM"]),
	],
	dependencies: [

	],
	targets: [
		.target(
			name: "VLCSPM",
			dependencies: [
				"MobileVLCKit",
			]
		),
		.testTarget(
			name: "VLCSPMTests",
			dependencies: ["VLCSPM"]
		),
		.binaryTarget(
				name: "MobileVLCKit",
				path: "Frameworks/MobileVLCKit.xcframework"
		),
	]
)
