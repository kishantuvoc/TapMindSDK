// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "TapMindSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "TapMindSDK",
            targets: ["TapMindSDK"]
        )
    ],
    dependencies: [
        // Google Mobile Ads SDK (SPM)
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git",
            from: "11.0.0"
        )
    ],
    targets: [
        // 🔹 Binary XCFramework
        .binaryTarget(
            name: "TapMindSDKBinary",
            path: "TapMindSDK.xcframework"
        ),

        // 🔹 Wrapper target to attach dependencies
        .target(
            name: "TapMindSDK",
            dependencies: [
                "TapMindSDKBinary",
                .product(
                    name: "GoogleMobileAds",
                    package: "swift-package-manager-google-mobile-ads"
                )
            ]
        )
    ]
)
