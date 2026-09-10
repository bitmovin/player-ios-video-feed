import BitmovinPlayer
import BitmovinPlayerVideoFeed
import SwiftUI

struct VideoFeedPageView: View {
    @ObservedObject var item: VideoFeedItem
    let index: Int
    let bottomSafeAreaInset: CGFloat

    var body: some View {
        VStack {
            if let player = item.player {
                ZStack {
                    VideoPlayerView(player: player)

                    VideoFeedPlayerUi(
                        index: index,
                        player: player,
                        bottomSafeAreaInset: bottomSafeAreaInset
                    )
                    // Recreate the player-bound state when this item receives a different pooled player.
                    .id(ObjectIdentifier(player))
                }
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(minHeight: 0, maxHeight: .infinity)
        .background(.black)
    }
}

#Preview("Page") {
    let sourceItem = StreamCatalog.items[0]
    let item = VideoFeedItem(
        id: "preview",
        sourceConfig: sourceItem.sourceConfig
    )
    let controller = VideoFeedPlayerController(
        items: [item],
        config: VideoFeedPlayerConfig(
            playerConfig: SampleConfig.makePlayerConfig(),
            analyticsConfig: .disabled,
            maxPlayers: 1,
            cachePlayerStateOnScrolling: true
        )
    )
    controller.prepare(index: 0)

    return GeometryReader { geometry in
        VideoFeedPageView(
            item: item,
            index: 0,
            bottomSafeAreaInset: geometry.safeAreaInsets.bottom
        )
        .ignoresSafeArea()
    }
}
