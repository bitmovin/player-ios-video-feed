import BitmovinPlayer
import BitmovinPlayerVideoFeed
import SwiftUI

struct VideoFeedView: View {
    @StateObject private var controller: VideoFeedPlayerController
    @State private var selectedItemID: String?

    init() {
        self.init(
            controller: VideoFeedPlayerController(
                items: StreamCatalog.items,
                config: VideoFeedPlayerConfig(
                    playerConfig: SampleConfig.makePlayerConfig(),
                    analyticsConfig: .disabled,
                    maxPlayers: SampleConfig.playerCount,
                    cachePlayerStateOnScrolling: true
                )
            )
        )
    }

    init(controller: @autoclosure @escaping () -> VideoFeedPlayerController) {
        // Forward the autoclosure into StateObject's lazy initializer so repeated view
        // initialization does not create players.
        _controller = StateObject(wrappedValue: controller())
        _selectedItemID = State(initialValue: nil)
    }

    var body: some View {
        // Capture the safe-area insets before the paging container expands edge to edge.
        GeometryReader { safeAreaGeometry in
            // Measure the expanded container so every paging target fills the physical screen.
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(Array(controller.items.enumerated()), id: \.element.id) { index, item in
                            VideoFeedPageView(
                                item: item,
                                index: index,
                                bottomSafeAreaInset: safeAreaGeometry.safeAreaInsets.bottom
                            )
                            .frame(minHeight: geometry.size.height)
                        }
                    }
                    .scrollTargetLayout()
                    .frame(minHeight: geometry.size.height)
                }
                .scrollPosition(id: $selectedItemID)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .frame(width: geometry.size.width)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            controller.pause()
                        }
                        .onEnded { _ in
                            controller.play()
                        }
                )
            }
            .background(Color.black)
            .ignoresSafeArea()
        }
        .onAppear {
            DebugConfig.logging.logger?.level = .verbose
            controller.prepare(index: 0)
            selectedItemID = controller.items.first?.id
        }
        .onChange(of: selectedItemID) { _, itemID in
            guard let itemID else {
                return
            }

            guard let item = controller.items.first(where: { $0.id == itemID }) else {
                return
            }

            controller.select(item: item)
        }
    }
}

private func makePreviewController() -> VideoFeedPlayerController {
    let items = StreamCatalog.items.map { item in
        VideoFeedItem(
            id: item.id,
            sourceConfig: item.sourceConfig
        )
    }
    let controller = VideoFeedPlayerController(
        items: items,
        config: VideoFeedPlayerConfig(
            playerConfig: SampleConfig.makePlayerConfig(),
            analyticsConfig: .disabled,
            maxPlayers: SampleConfig.playerCount,
            cachePlayerStateOnScrolling: true
        )
    )
    controller.prepare(index: 0)

    return controller
}

#Preview("Feed") {
    VideoFeedView(controller: makePreviewController())
}
