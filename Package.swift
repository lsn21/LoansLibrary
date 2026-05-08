// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "LoansLibrary",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "LoansLibrary",
            targets: ["LoansLibrary"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            from: "10.0.0"
        )
    ],
    targets: [
        .target(
            name: "LoansLibrary",
            dependencies: [
                .product(name: "FirebaseCore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk")
            ],
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [.v5]
)
