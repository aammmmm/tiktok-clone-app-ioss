//
//  APIProviders.swift
//  Core
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Moya
import Core

public enum APIProviders {
    case getVideos
    case getPosts
    case createPost(CreatePostRequest)
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
//    btter bikin jadi obj dulu
    public var task: Task {
        switch self {
        case .getVideos, .getPosts:
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
