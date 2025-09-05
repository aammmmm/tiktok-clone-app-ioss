//
//  CreatePostRequest.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 03/09/25.
//

import Foundation
import Core

public struct CreatePostRequest: Codable {
    let id: String
    let title: String
    let thumbnailUrl: String
    let duration: String
    let uploadTime: String
    let views: String
    let author: String
    let videoUrl: String
    let description: String
    let subscriber: String
    let isLive: Bool

    public init(video: VideoEntity) {
        self.id = video.id
        self.title = video.title
        self.thumbnailUrl = video.thumbnailUrl
        self.duration = video.duration
        self.uploadTime = video.uploadTime
        self.views = video.views
        self.author = video.author
        self.videoUrl = video.videoUrl
        self.description = video.description
        self.subscriber = video.subscriber
        self.isLive = video.isLive
    }
}
