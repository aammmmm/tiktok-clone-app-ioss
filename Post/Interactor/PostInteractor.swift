//
//  PostInteractor.swift
//  Post
//
//  Created by Abraham Putra Lukas on 31/08/25.
//

import Foundation
import Core

final class PostInteractor: PostPresenterToInteractor {
    weak var output: PostInteractorToPresenter?
    private var cache: [VideoEntity] = []
    private var isFetching = false

    func fetchPosts(page: Int) {
        guard !isFetching else { return }
        isFetching = true
        output?.didStartFetchingPosts()

        APIService.shared.request(.getPosts) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            switch result {
            case .success(let response):
                do {
                    let videos = try JSONDecoder().decode([VideoEntity].self, from: response.data)
                    if page == 1 {
                        self.cache = videos
                    } else {
                        self.cache.append(contentsOf: videos)
                    }
                    self.output?.didFetchPosts(videos, page: page)
                } catch {
                    self.output?.didFailToFetchPosts(error)
                }
            case .failure(let error):
                self.output?.didFailToFetchPosts(error)
            }
        }
    }

    func postEntity(at index: Int) -> VideoEntity? {
        guard index >= 0 && index < cache.count else { return nil }
        return cache[index]
    }

    func createPost(video: VideoEntity) {
        let request = CreatePostRequest(video: video)

        APIService.shared.request(.createPost(request)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.cache.insert(video, at: 0)
                self.output?.didCreatePost(video)
            case .failure(let error):
                self.output?.didFailToCreatePost(error)
            }
        }
    }
}

