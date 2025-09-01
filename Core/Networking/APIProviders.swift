//
//  APIProviders.swift
//  Core
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Moya

// list endpoint
public enum APIProviders {
    case getVideos
    case getPosts
    case createPost(video: VideoEntity)
}

extension APIProviders: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: Constants.API.baseURL) else { fatalError() }
        return url
    }
    
    public var path: String {
        switch self {
        case .getVideos:
            return ""
        case .getPosts, .createPost:
            return "/posts"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getVideos, .getPosts:
            return .get
        case .createPost:
            return .post
        }
    }
    
//    specify request (body, param, objects)
    public var task: Task {
        switch self {
        case .getVideos, .getPosts:
            return .requestPlain
        case .createPost(let video):
            let params: [String: Any] = [
                "id": video.id,
                "title": video.title,
                "thumbnailUrl": video.thumbnailUrl,
                "duration": video.duration,
                "uploadTime": video.uploadTime,
                "views": video.views,
                "author": video.author,
                "videoUrl": video.videoUrl,
                "description": video.description,
                "subscriber": video.subscriber,
                "isLive": video.isLive
            ]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    public var sampleData: Data {
        return Data()
    }
}
