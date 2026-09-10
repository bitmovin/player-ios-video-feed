# Bitmovin Player Video Feed

`BitmovinPlayerVideoFeed` manages a reusable pool of Bitmovin Player instances for video-feed playback.
Your application controls feed layout, renders the player views, and reports the currently selected item.

## Requirements

- iOS 15 or tvOS 15 or later
- Bitmovin Player iOS SDK 3.122.0 or later
- A Bitmovin Player license key

## Installation

Add this repository as a Swift Package dependency in Xcode, select a released version, and add the
`BitmovinPlayerVideoFeed` product to your application target. The package downloads the prebuilt
XCFramework and includes the Bitmovin Player SDK dependency.

See [CHANGELOG.md](CHANGELOG.md) for release history.

## Usage

Create feed items from your `[SourceConfig]` collection. Item IDs must be nonempty and unique across
the feed, including any items appended later.

```swift
import BitmovinPlayer
import BitmovinPlayerVideoFeed

let playerConfig = PlayerConfig()
playerConfig.key = "YOUR-PLAYER-LICENSE-KEY"
playerConfig.styleConfig.isUiEnabled = false
playerConfig.styleConfig.scalingMode = .zoom

let items = sourceConfigs.enumerated().map { index, sourceConfig in
    VideoFeedItem(
        id: "video-\(index)",
        sourceConfig: sourceConfig
    )
}

let controller = VideoFeedPlayerController(
    items: items,
    config: VideoFeedPlayerConfig(playerConfig: playerConfig)
)

controller.prepare(index: 0)
```

Keep the controller alive for the lifetime of the feed. Call `prepare(index:)` with a valid initial
index to assign players and start playback. Observe each `VideoFeedItem` and attach its non-`nil`
`player` to the corresponding player view; assignments can change as players are reused.

Call `select(index:)` when the visible item changes. It pauses the previous item and starts the
selected one. Use `play()` and `pause()` to control the current item. Append more content with
`appendItems(_:)`, using IDs that remain unique across the entire feed.

## Configuration

`VideoFeedPlayerConfig` accepts:

| Parameter | Purpose | Default |
| --- | --- | --- |
| `playerConfig` | Bitmovin Player configuration, including the license key. | Required |
| `analyticsConfig` | Analytics configuration for the players. | `.enabled` |
| `maxPlayers` | Number of reusable player instances; must be greater than zero. | `5` |
| `cachePlayerStateOnScrolling` | Save the playback position when leaving an item and seek back when revisiting it. | `true` |

## Sample

Clone this repository and open `BitmovinPlayerVideoFeed.xcworkspace`. Select the
`BitmovinPlayerVideoFeedExample` scheme, set your player license key in `SampleConfig.swift`, and
select your development team before running on a device. The sample requires iOS 17 or later and
uses the binary package in this repository.
