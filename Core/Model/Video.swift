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

}


