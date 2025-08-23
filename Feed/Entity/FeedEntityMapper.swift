//
//  FeedEntityMapper.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 22/08/25.
//
import Core

enum FeedEntityMapper {
    static func map(_ video: VideoEntity) -> FeedEntity {
        FeedEntity(
            id: video.id,
            title: video.title,
            thumbnailUrl: video.thumbnailUrl,
            views: video.views,
            author: video.author
        )
    }
    
    static func mapList(_ videos: [VideoEntity]) -> [FeedEntity] {
        videos.map(map(_:))
    }
}
