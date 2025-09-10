//
//  PostWorker.swift
//  PostWorker
//
//  Created by Abraham Putra Lukas on 04/09/25.
//

import DataService
import Moya
import Core
import Domain

public class PostWorkerr: PostWorkerProtocol {
    public weak var responseDelegate: PostWorkerResponseProtocol?
    private let provider: MoyaProvider<APIProviders>

    public init(provider: MoyaProvider<APIProviders> = MoyaProvider<APIProviders>()) {
        self.provider = provider
    }

    public func fetchPosts(page: Int) {
        provider.request(.getPosts) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let posts = try decoder.decode([VideoEntity].self, from: result.data)
                    self.responseDelegate?.didSuccessFetchPosts(posts, page: page)
                } catch {
                    print(error)
                    self.responseDelegate?.didFailFetchPosts(error: "Failed to decode posts")
                }
            case .failure(let error):
                self.responseDelegate?.didFailFetchPosts(error: error.localizedDescription)
            }
        }
    }

    public func createPost(request: CreatePostRequest) {
            provider.request(.createPost(request)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    let decoder = JSONDecoder()
                    let video = try decoder.decode(VideoEntity.self, from: result.data)
                    self.responseDelegate?.didSuccessCreatePost(video)
                } catch {
                    self.responseDelegate?.didFailCreatePost(error: error.localizedDescription)
                }
            case .failure(let error):
                self.responseDelegate?.didFailCreatePost(error: error.localizedDescription)
            }
        }
    }
}
