//
//  FeedEntityMapper.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 22/08/25.
//
// FeedEntityMapper.swift
import Core

enum FeedEntityMapper {
    static func map(_ v: VideoEntity) -> FeedEntity {
        FeedEntity(id: v.id, title: v.title, thumbnailUrl: v.thumbnailUrl, views: v.views, author: v.author, isLive: v.isLive)
    }
    static func mapList(_ list: [VideoEntity]) -> [FeedEntity] { list.map(map(_:)) }
}

