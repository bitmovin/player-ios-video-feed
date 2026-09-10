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
            url: "https://cdn.bitmovin.com/player/ios_tvos/videofeed/0.1.0-a.1/BitmovinPlayerVideoFeed.zip",
            checksum: "49c86571697161e5f67c02f00afe60c5266f7fa17d4ec88ba2e94f5f6be1184e"
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
