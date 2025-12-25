// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TapMindSDK",
    platforms: [
        .iOS(.v13) // The minimum iOS version your SDK supports
    ],
    products: [
        // This is what users will see when they add the package
        .library(
            name: "TapMindSDK",
            targets: ["TapMindSDKTarget"])
    ],
    dependencies: [
        // Google Mobile Ads official Swift Package
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git",
            "12.14.0"..<"13.0.0"
        )
    ],
    targets: [
        // 1. The actual binary framework
        .binaryTarget(
            name: "TapMindSDKBinary",
            path: "TapMindSDK.xcframework"
        ),
        // 2. The wrapper target that bridges your binary and Google Mobile Ads
        .target(
            name: "TapMindSDKTarget",
            dependencies: [
                .target(name: "TapMindSDKBinary"),
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads")
            ],
            path: "Sources/TapMindSDK" // Points to your physical folder
        )
    ]
)
