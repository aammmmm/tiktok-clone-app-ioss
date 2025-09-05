//
//  PlayerWorker.swift
//  PlayerWorker
//
//  Created by Abraham Putra Lukas on 04/09/25.
//

import Core
import Moya
import DataService

public class PlayerWorkerr: PlayerWorkerProtocol {
    public weak var responseDelegate: PlayerWorkerResponseDelegate?
    private let provider: MoyaProvider<APIProviders>
    
    public init(provider: MoyaProvider<APIProviders> = MoyaProvider<APIProviders>()) {
        self.provider = provider
    }
    
    public func fetchVideoDetail(by id: String) {
        provider.request(.getVideoById(id: id)) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                do {
                    let videos = try decoder.decode([VideoEntity].self, from: response.data)
                    if let firstVideo = videos.first {
                        self.responseDelegate?.didSuccessFetchVideoDetail(firstVideo)
                    } else {
                        self.responseDelegate?.didFailFetchVideoDetail(error: "Empty video array")
                    }
                } catch {
                    // coba decode ke APIErrorResponse
                    do {
                        let apiError = try decoder.decode(APIErrorResponse.self, from: response.data)
                        self.responseDelegate?.didFailFetchVideoDetail(error: apiError.error.message)
                    } catch {
                        print("DEBUG: Decoding error = \(error)")
                        self.responseDelegate?.didFailFetchVideoDetail(error: "Failed to decode video detail")
                    }
                }
            case .failure(let error):
                self.responseDelegate?.didFailFetchVideoDetail(error: error.localizedDescription)
            }
        }
    }
}
