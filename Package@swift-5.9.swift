// swift-tools-version:5.9
// (Xcode15.0+)

import PackageDescription

let package = Package(
    name: "LiveKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .macCatalyst(.v14),
        .visionOS(.v1),
        .tvOS(.v17),
    ],
    products: [
        .library(
            name: "LiveKit",
            targets: ["LiveKit"]
        ),
    ],
    dependencies: [
        // LK-Prefixed Dynamic WebRTC XCFramework
        .package(url: "https://github.com/webcpu/webrtc-xcframework.git", from: "125.6422.10"),
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.26.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.5.4"),
        // Only used for DocC generation
        .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.3.0"),
        // Only used for Testing
        .package(url: "https://github.com/vapor/jwt-kit.git", from: "4.13.4"),
    ],
    targets: [
        .target(
            name: "LiveKit",
            dependencies: [
                .product(name: "LiveKitWebRTC", package: "webrtc-xcframework"),
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
                .product(name: "Logging", package: "swift-log"),
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ],
            swiftSettings: [
                .enableExperimentalFeature("AccessLevelOnImport"),
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        ),
        .testTarget(
            name: "LiveKitTests",
            dependencies: [
                "LiveKit",
                .product(name: "JWTKit", package: "jwt-kit"),
            ]
        ),
        .testTarget(
            name: "LiveKitTestsObjC",
            dependencies: [
                "LiveKit",
                .product(name: "JWTKit", package: "jwt-kit"),
            ]
        ),
    ],
    swiftLanguageVersions: [
        .v5,
    ]
)
