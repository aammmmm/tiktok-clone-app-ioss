//
//  APIProviders.swift
//  Core
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Moya

public enum APIProviders {
    case getVideos
}

extension APIProviders: TargetType {
    public var baseURL: URL { URL(string: "https://www.apirequest.in/video/api")! }
    public var path: String { "" }
    public var method: Moya.Method { .get }
    public var task: Task { .requestPlain }
    public var headers: [String: String]? { ["Content-Type": "application/json"] }
}
