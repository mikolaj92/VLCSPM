// swift-tools-version: 5.6
import PackageDescription

// This repository does not vendor MobileVLCKit. The original
// Frameworks/MobileVLCKit.xcframework path (and the .gitattributes LFS
// rule for it) was never committed — git history has no Frameworks/
// tree and no LFS pointer.
//
// Official VideoLAN MobileVLCKit 3.7.3 is a CocoaPods tar.xz, which
// SwiftPM cannot use as a binaryTarget:
// https://download.videolan.org/pub/cocoapods/prod/MobileVLCKit-3.7.3-319ed2c0-79128878.tar.xz
//
// SwiftPM requires a zip that contains MobileVLCKit.xcframework. The
// published artifact below is that zip (SHA256 verified).
let mobileVLCKitURL = "https://github.com/showbie/MobileVLCKit-SPM/releases/download/3.7.3/MobileVLCKit.xcframework.zip"
let mobileVLCKitChecksum = "0346e458e119d57d4768d4096e2f7b4f77b7a0df4e21d0e728856f309cc6e8ab"

let package = Package(
	name: "VLCSPM",
	platforms: [
		.iOS(.v12),
	],
	products: [
		.library(
			name: "VLCSPM",
			targets: ["VLCSPM"]),
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
			url: mobileVLCKitURL,
			checksum: mobileVLCKitChecksum
		),
	]
)
