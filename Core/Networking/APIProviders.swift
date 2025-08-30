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
    
    public var path: String {
        switch self {
        case .getVideos:
            return ""
        }
    }
    
    public var method: Moya.Method { .get }
    
//    specify request (body, param, objects)
    public var task: Task {
        switch self {
        case .getVideos:
            return .requestPlain
//        case .postComment(_, let commentText):
//            let parameters: [String: Any] = ["text": commentText]
//            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
//    headers
    public var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    public var sampleData: Data {
        return Data()
    }
}
