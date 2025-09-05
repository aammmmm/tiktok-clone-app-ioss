//
//  FeedWorker.swift
//  FeedWorker
//
//  Created by Abraham Putra Lukas on 03/09/25.
//

import DataService
import Moya
import Core

public protocol FeedWorkerProtocol: AnyObject {
    var responseDelegate: FeedWorkerResponseDelegate? { get set }
    func fetchVideos(page: Int)
}

public protocol FeedWorkerResponseDelegate: AnyObject {
    func didSuccessFetchVideos(_ videos: [VideoEntity], page: Int)
    func didFailFetchVideos(error: String)
}

public class FeedWorkerr: FeedWorkerProtocol {
    public weak var responseDelegate: FeedWorkerResponseDelegate?
    private let provider: MoyaProvider<APIProviders>

    public init(provider: MoyaProvider<APIProviders> = MoyaProvider<APIProviders>()) {
        self.provider = provider
    }

    public func fetchVideos(page: Int) {
        provider.request(.getVideos) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let videos = try decoder.decode([VideoEntity].self, from: result.data)
                    self.responseDelegate?.didSuccessFetchVideos(videos, page: page)
                } catch {
                    print(error)
                    self.responseDelegate?.didFailFetchVideos(error: "Failed to decode videos")
                }
            case .failure(let error):
                self.responseDelegate?.didFailFetchVideos(error: error.localizedDescription)
            }
        }
    }
}
