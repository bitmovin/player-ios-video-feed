// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "BitmovinPlayerVideoFeed",
    platforms: [.iOS(.v15), .tvOS(.v15)],
    products: [
        .library(name: "BitmovinPlayerVideoFeed", targets: ["BitmovinPlayerVideoFeedTarget"]),
    ],
    dependencies: [
        .package(url: "https://github.com/bitmovin/player-ios.git", from: "3.122.0"),
    ],
    targets: [
        .binaryTarget(
            name: "BitmovinPlayerVideoFeed",
            url: "https://cdn.bitmovin.com/player/ios_tvos/videofeed/0.1.0/BitmovinPlayerVideoFeed.zip",
            checksum: "fe64437b193853d8875d00a47d7e746a77b68c039ac1cde7fad389ac7b777700"
        ),
        .target(
            name: "BitmovinPlayerVideoFeedTarget",
            dependencies: [
                "BitmovinPlayerVideoFeed",
                .product(name: "BitmovinPlayer", package: "player-ios"),
            ]
        ),
    ]
)
