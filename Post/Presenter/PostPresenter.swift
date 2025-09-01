//
//  PostPresenter.swift
//  Post
//
//  Created by Abraham Putra Lukas on 31/08/25.
//

import Foundation
import Core

final class PostPresenter {
    weak var view: PostPresenterToView?
    var interactor: PostPresenterToInteractor?
    var router: PostPresenterToRouter?

    private var page = 1
    private var isLoading = false
    private var isSearching = false
}

extension PostPresenter: PostViewToPresenter {
    func viewDidLoad() {
        page = 1
        interactor?.fetchPosts(page: page)
    }

    func loadMorePosts() {
        guard !isLoading, !isSearching else { return }
        isLoading = true
        page += 1
        interactor?.fetchPosts(page: page)
    }

    func didSelectItem(at index: Int) {
        guard let video = interactor?.postEntity(at: index),
              let view = view else { return }
        router?.navigateToPlayer(from: view, with: video)
    }

    func didTapSearch(query: String) {
        if query.isEmpty {
            isSearching = false
            page = 1
            interactor?.fetchPosts(page: page)
        } else {
            isSearching = true
            interactor?.searchPosts(query: query)
        }
    }

    func didTapCreate(video: VideoEntity) {
        interactor?.createPost(video: video)
    }
}

extension PostPresenter: PostInteractorToPresenter {
    func didStartFetchingPosts() {
        view?.showLoading(true)
    }

    func didFetchPosts(_ posts: [VideoEntity], page: Int) {
        isLoading = false
        view?.showLoading(false)
        if page == 1 {
            view?.showPosts(posts)
        } else {
            view?.appendPosts(posts)
        }
    }

    func didFailToFetchPosts(_ error: Error) {
        isLoading = false
        view?.showLoading(false)
        view?.showError(error.localizedDescription)
    }

    func didSearchPosts(_ posts: [VideoEntity]) {
        view?.showPosts(posts)
    }

    func didCreatePost(_ video: VideoEntity) {
        // langsung update ke UI (prepend)
        var newList = [video]
        view?.appendPosts(newList)
    }

    func didFailToCreatePost(_ error: Error) {
        view?.showError("Failed to create post: \(error.localizedDescription)")
    }
}
