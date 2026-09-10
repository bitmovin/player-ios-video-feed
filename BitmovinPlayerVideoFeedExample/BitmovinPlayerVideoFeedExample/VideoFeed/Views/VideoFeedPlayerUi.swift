import BitmovinPlayer
import SwiftUI

struct VideoFeedPlayerUi: View {
    private let index: Int
    private let bottomSafeAreaInset: CGFloat
    @StateObject private var playerState: PlayerState

    init(
        index: Int,
        player: Player,
        bottomSafeAreaInset: CGFloat
    ) {
        self.index = index
        self.bottomSafeAreaInset = bottomSafeAreaInset
        _playerState = StateObject(wrappedValue: PlayerState(player: player))
    }

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Text("Video \(index + 1)")
                    .font(.title)
                    .bold()

                Spacer()
            }

            PlaybackProgressView(playerState: playerState)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 16)
        .padding(.bottom, bottomSafeAreaInset + 16)
        .background(alignment: .bottom) {
            LinearGradient(
                colors: [.clear, .black.opacity(0.6)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 200)
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

private struct PlaybackProgressView: View {
    @ObservedObject var playerState: PlayerState

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(.white.opacity(0.8))
                .frame(width: max(geometry.size.width * progress, 1))
                .frame(maxWidth: geometry.size.width, alignment: .leading)
                .animation(.linear(duration: 0.1), value: progress)
        }
        .frame(height: 8)
        .clipShape(.rect(cornerRadius: 8))
    }

    private var progress: Double {
        guard playerState.duration.isFinite, playerState.duration > 0 else {
            return 0
        }

        return min(max(playerState.currentTime / playerState.duration, 0), 1)
    }
}
