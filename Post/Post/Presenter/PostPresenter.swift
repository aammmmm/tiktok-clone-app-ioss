//
//  PostPresenter.swift
//  Post
//
//  Created by Abraham Putra Lukas on 31/08/25.
//

import Foundation
import Domain

final class PostPresenter {
    weak var view: PostPresenterToView?
    var interactor: PostPresenterToInteractor?
    var router: PostPresenterToRouter?

    private var page = 1
    private var isLoading = false
    private var postsCache: [VideoEntity] = []
}

extension PostPresenter: PostViewToPresenter {
    func viewDidLoad() {
        page = 1
        postsCache.removeAll()
        view?.showLoading(true)
        interactor?.fetchPosts(page: page)
    }

    func loadMorePosts() {
        guard !isLoading else { return }
        isLoading = true
        view?.showLoading(true)
        page += 1
        print("DEBUG: loadMorePosts called, page=\(page)")
        interactor?.fetchPosts(page: page)
    }
    
    func didSelectItem(at index: Int) {
        let video = postsCache[index]
        if let view = view {
            router?.navigateToPlayer(from: view, with: video.id)
        }
    }

    func didTapCreate(request: CreatePostRequest) {
        view?.showLoading(true)
        interactor?.createPost(request: request)
    }

    func didPullToRefresh() {
        guard !isLoading else { return }
        page = 1
        postsCache.removeAll()
        view?.showLoading(true)
        interactor?.fetchPosts(page: page)
    }
}

extension PostPresenter: PostInteractorToPresenter {
    func didFetchPosts(_ posts: [VideoEntity], page: Int) {
        print("DEBUG: didFetchPosts called, page=\(page), count=\(posts.count)")
        isLoading = false
        view?.showLoading(false)

        if page == 1 {
            postsCache = posts
            view?.showPosts(posts)
        } else {
            postsCache.append(contentsOf: posts)
            view?.appendPosts(posts)
        }
    }

    func didFailToFetchPosts(_ error: Error) {
        isLoading = false
        view?.showLoading(false)
        view?.showError(error.localizedDescription)
    }

    func didCreatePost(_ video: VideoEntity) {
        isLoading = false  // Business logic
        view?.showLoading(false)
        
        postsCache.insert(video, at: 0)
        view?.showPosts(postsCache)
    }

    func didFailToCreatePost(_ error: Error) {
        isLoading = false  // Business logic
        view?.showLoading(false)
        view?.showError("Failed to create post: \(error.localizedDescription)")
    }
}
