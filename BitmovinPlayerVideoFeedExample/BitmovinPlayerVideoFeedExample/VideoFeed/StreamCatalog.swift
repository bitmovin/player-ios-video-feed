import BitmovinPlayer
import BitmovinPlayerVideoFeed
import Foundation

enum StreamCatalog {
    static let items = streamURLs.enumerated().map { index, url in
        VideoFeedItem(
            id: "video-\(index)",
            sourceConfig: SourceConfig(url: url, type: .hls)
        )
    }

    private static let streamURLs = [
        URL(string: "https://storage.googleapis.com/bitmovin-content-cdn-origin/content/short_form_content/short_form_1/m3u8/master.m3u8")!,
        URL(string: "https://storage.googleapis.com/bitmovin-content-cdn-origin/content/short_form_content/short_form_2/m3u8/master.m3u8")!,
        URL(string: "https://storage.googleapis.com/bitmovin-content-cdn-origin/content/short_form_content/short_form_3/m3u8/master.m3u8")!,
        URL(string: "https://storage.googleapis.com/bitmovin-content-cdn-origin/content/short_form_content/short_form_4/m3u8/master.m3u8")!,
        URL(string: "https://storage.googleapis.com/bitmovin-content-cdn-origin/content/short_form_content/short_form_5/m3u8/master.m3u8")!,
        URL(string: "https://storage.googleapis.com/bitmovin-content-cdn-origin/content/short_form_content/short_form_6/m3u8/master.m3u8")!,
        URL(string: "https://storage.googleapis.com/bitmovin-content-cdn-origin/content/short_form_content/short_form_7/m3u8/master.m3u8")!,
        URL(string: "https://storage.googleapis.com/bitmovin-content-cdn-origin/content/short_form_content/short_form_8/m3u8/master.m3u8")!,
        URL(string: "https://storage.googleapis.com/bitmovin-content-cdn-origin/content/short_form_content/short_form_9/m3u8/master.m3u8")!,
        URL(string: "https://storage.googleapis.com/bitmovin-content-cdn-origin/content/short_form_content/short_form_10/m3u8/master.m3u8")!,
        URL(string: "https://storage.googleapis.com/bitmovin-content-cdn-origin/content/short_form_content/short_form_11/m3u8/master.m3u8")!,
        URL(string: "https://storage.googleapis.com/bitmovin-content-cdn-origin/content/short_form_content/short_form_12/m3u8/master.m3u8")!,
    ]
}
