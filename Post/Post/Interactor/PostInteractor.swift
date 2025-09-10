//
//  PostInteractor.swift
//  Post
//
//  Created by Abraham Putra Lukas on 31/08/25.
//

import Foundation
import Domain
import DataService
import PostWorker

class PostInteractor: PostPresenterToInteractor {
    weak var presenter: PostInteractorToPresenter?
    private let worker: PostWorkerr

    init(worker: PostWorkerr = PostWorkerr()) {
        self.worker = worker
        self.worker.responseDelegate = self
    }

    func fetchPosts(page: Int) {
        worker.fetchPosts(page: page)
    }

    func createPost(request: CreatePostRequest) {
        worker.createPost(request: request)
    }
}

extension PostInteractor: PostWorkerResponseProtocol {
    func didSuccessFetchPosts(_ posts: [VideoEntity], page: Int) {
        presenter?.didFetchPosts(posts, page: page)
    }

    func didFailFetchPosts(error: String) {
        presenter?.didFailToFetchPosts(error)
    }

    func didSuccessCreatePost(_ video: VideoEntity) {
        presenter?.didCreatePost(video)
    }

    func didFailCreatePost(error: String) {
        presenter?.didFailToCreatePost(error)
    }
}
