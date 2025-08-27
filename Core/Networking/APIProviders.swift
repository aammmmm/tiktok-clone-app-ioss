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
//    case postComment(videoId: String, commentText: String)
}


extension APIProviders: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: Constants.API.baseURL) else { fatalError() }
        return url
    }
    
    public var path: String { "" }
    
    public var method: Moya.Method { .get }
    
//    specify request (body, param, objects)
    public var task: Task { .requestPlain }
    
//    headers
    public var headers: [String: String]? { ["Content-Type": "application/json"] }
    
    public var sampleData: Data {
        return Data()
    }
}
