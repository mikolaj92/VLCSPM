# VLCSPM

Swift Package Manager wrapper for [MobileVLCKit](https://code.videolan.org/videolan/VLCKit).

`Package.swift` ships a `binaryTarget` that downloads a published
`MobileVLCKit.xcframework.zip`. This repository does **not** contain
the xcframework, and it never did: `Frameworks/` is absent from git
history, and the old Git LFS rule pointed at a file that was never
committed.

## Install

Add this package as a dependency, then `import VLCSPM` (which re-exports
`MobileVLCKit`).

```swift
dependencies: [
    .package(url: "https://github.com/mikolaj92/VLCSPM", branch: "main"),
]
```

## Where the binary comes from

SwiftPM `binaryTarget` only accepts a **zip** whose payload is an
`.xcframework`. VideoLAN’s official MobileVLCKit 3.7.3 build is a
**tar.xz**, so it cannot be referenced from `Package.swift`.

| Role | URL |
| --- | --- |
| **SwiftPM fetch path** (what this package resolves) | https://github.com/showbie/MobileVLCKit-SPM/releases/download/3.7.3/MobileVLCKit.xcframework.zip |
| **Canonical VideoLAN artifact** (CocoaPods / not SPM-compatible) | https://download.videolan.org/pub/cocoapods/prod/MobileVLCKit-3.7.3-319ed2c0-79128878.tar.xz |

Checksum of the SwiftPM zip (SHA-256):

```
0346e458e119d57d4768d4096e2f7b4f77b7a0df4e21d0e728856f309cc6e8ab
```

The zip contains `MobileVLCKit.xcframework` (`org.videolan.mobilevlckit`)
for iOS device (`ios-arm64_armv7_armv7s`) and simulator
(`ios-arm64_i386_x86_64-simulator`).

To re-check the published zip without Xcode:

```sh
./scripts/verify-mobilevlckit.sh
```

VideoLAN also publishes a first-party Swift package for **VLCKit 4**
(unified xcframework, not MobileVLCKit 3.x) at
https://github.com/videolan/vlckit. This wrapper stays on MobileVLCKit
3.7.3 to match the original target name.

MobileVLCKit is LGPLv2.1 or later. See
[VideoLAN’s VLCKit license](https://code.videolan.org/videolan/VLCKit/-/blob/master/COPYING).
