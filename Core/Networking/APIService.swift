//
//  APIService.swift
//  Core
//
//  Created by Abraham Putra Lukas on 27/08/25.
//

import Foundation
import Moya

public final class APIService {
    public static let shared = APIService()
    private let provider = MoyaProvider<APIProviders>()

    private init() {}

//    closure callback jalan ketika request async selesai, @escaping krn dipanggil di luar scope func, yaitu ketika selesai, response (status code, data, header), error
    public func request(_ target: APIProviders, completion: @escaping (Result<Response, MoyaError>) -> Void) {
        provider.request(target, completion: completion)
    }
}
