//
//  APIProviders.swift
//  Core
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Moya
import Domain

public enum APIProviders {
    case getVideos
    case getVideoById(id: String)
    case getPosts
    case createPost(CreatePostRequest)
}

extension APIProviders: TargetType {
    public var baseURL: URL {
        switch self {
        case .getVideoById:
            guard let url = URL(string: "http://localhost:3002") else {
                fatalError("Invalid remote API URL")
            }
            return url
        default:
            guard let url = URL(string: "http://localhost:3001") else {
                fatalError("Invalid local API URL")
            }
            return url
        }
    }
    
    public var path: String {
        switch self {
        case .getVideos:
            return ""
        case .getPosts, .createPost:
            return "/posts"
        case .getVideoById(id: let id):
            return "id/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getVideos, .getPosts, .getVideoById:
            return .get
        case .createPost:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .getVideos, .getPosts, .getVideoById:
            return .requestPlain
        case .createPost(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    public var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    public var sampleData: Data {
        return Data()
    }
}
