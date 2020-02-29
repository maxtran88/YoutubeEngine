import Foundation
import SwiftyJSON

extension Video: JSONRepresentable {
    init?(json: JSON) {
        guard let id = json["id"].string else {
            return nil
        }

        self.id = id
        snippet = VideoSnippet(json: json[Part.snippet.parameterValue])
        contentDetails = VideoContentDetails(json: json[Part.contentDetails.parameterValue])
        statistics = VideoStatistics(json: json[Part.statistics.parameterValue])
    }
}

extension VideoSnippet: JSONRepresentable {
    init?(json: JSON) {
        /*
         guard let publishDate = json["publishedAt"].date,
            let title = json["title"].string,
            let channelId = json["channelId"].string,
            let channelTitle = json["channelTitle"].string,
            let defaultImage = Image(json: json["thumbnails"]["default"]),
            let mediumImage = Image(json: json["thumbnails"]["medium"]),
            let highImage = Image(json: json["thumbnails"]["high"]) else {
               return nil
         }
         */

        let publishDate = json["publishedAt"].date
        let title = json["title"].string
        let channelId = json["channelId"].string
        let channelTitle = json["channelTitle"].string
        let defaultImage = Image(json: json["thumbnails"]["default"])
        let mediumImage = Image(json: json["thumbnails"]["medium"])
        let highImage = Image(json: json["thumbnails"]["high"])

        self.title = title
        self.publishDate = publishDate
        self.channelId = channelId
        self.channelTitle = channelTitle
        self.defaultImage = defaultImage
        self.mediumImage = mediumImage
        self.highImage = highImage
    }
}

extension VideoStatistics: JSONRepresentable {
    init?(json: JSON) {
        guard json.exists() else {
            return nil
        }

        views = json["viewCount"].string.flatMap { Int($0) }
        likes = json["likeCount"].string.flatMap { Int($0) }
        dislikes = json["dislikeCount"].string.flatMap { Int($0) }
    }
}

extension VideoContentDetails: JSONRepresentable {
    init?(json: JSON) {
        guard let duration = json["duration"].duration else {
            return nil
        }
        self.duration = duration
    }
}
