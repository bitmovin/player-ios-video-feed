import BitmovinPlayer
import Foundation

enum SampleConfig {
    static let playerLicenseKey = "<PLAYER_LICENSE_KEY>"
    static let playerCount = 5

    static func makePlayerConfig() -> PlayerConfig {
        let playerConfig = PlayerConfig()
        playerConfig.key = playerLicenseKey
        playerConfig.styleConfig.isUiEnabled = false
        playerConfig.styleConfig.scalingMode = .zoom
        // Emit frequent time updates so the custom progress view advances smoothly.
        playerConfig.tweaksConfig.timeChangedInterval = 0.1
        return playerConfig
    }
}
