//
//  CreatePostRequest.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 03/09/25.
//

import Foundation

public struct CreatePostRequest: Codable {
    public let title: String
    public let thumbnailUrl: String
    public let duration: String
    public let uploadTime: String
    public let views: String
    public let author: String
    public let videoUrl: String
    public let description: String?
    public let subscriber: String
    public let isLive: Bool
    
    public init(
        title: String,
        thumbnailUrl: String,
        duration: String,
        uploadTime: String,
        views: String,
        author: String,
        videoUrl: String,
        description: String?,
        subscriber: String,
        isLive: Bool
    ) {
        self.title = title
        self.thumbnailUrl = thumbnailUrl
        self.duration = duration
        self.uploadTime = uploadTime
        self.views = views
        self.author = author
        self.videoUrl = videoUrl
        self.description = description
        self.subscriber = subscriber
        self.isLive = isLive
    }
}
