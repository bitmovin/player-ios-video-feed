import BitmovinPlayer
import Combine
import Foundation

final class PlayerState: ObservableObject {
    @Published private(set) var currentTime: TimeInterval = 0
    @Published private(set) var duration: TimeInterval = 0

    private weak var player: Player?
    private var cancellables = Set<AnyCancellable>()

    init(player: Player) {
        self.player = player
        duration = player.duration

        player.events
            .on(TimeChangedEvent.self)
            .sink { [weak self] event in
                self?.currentTime = event.currentTime
            }
            .store(in: &cancellables)

        player.events
            .on(DurationChangedEvent.self)
            .sink { [weak self] event in
                self?.duration = event.duration
            }
            .store(in: &cancellables)

        player.events
            .on(ReadyEvent.self)
            .sink { [weak self, weak player] _ in
                guard let self, let player else {
                    return
                }

                duration = player.duration
            }
            .store(in: &cancellables)
    }
}
