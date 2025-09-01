//
//  Video.swift
//  Core
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

public struct VideoEntity: Decodable {
    public let id: String
    public let title: String
    public let thumbnailUrl: String
    public let duration: String
    public let uploadTime: String
    public let views: String
    public let author: String
    public let videoUrl: String
    public let description: String
    public let subscriber: String
    public let isLive: Bool
    
    public init(
        id: String,
        title: String,
        thumbnailUrl: String,
        duration: String,
        uploadTime: String,
        views: String,
        author: String,
        videoUrl: String,
        description: String,
        subscriber: String,
        isLive: Bool
    ) {
        self.id = id
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


