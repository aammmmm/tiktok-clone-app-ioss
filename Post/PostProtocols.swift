//
//  PostProtocols.swift
//  Post
//
//  Created by Abraham Putra Lukas on 31/08/25.
//

import UIKit
import Core

// MARK: - View <-> Presenter
protocol PostViewToPresenter {
    func viewDidLoad()
    func loadMorePosts()
    func didSelectItem(at index: Int)
    func didTapSearch(query: String)
    func didTapCreate(video: VideoEntity)
}

protocol PostPresenterToView: AnyObject {
    func showPosts(_ posts: [VideoEntity])
    func appendPosts(_ posts: [VideoEntity])
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
}

// MARK: - Presenter <-> Interactor
protocol PostPresenterToInteractor {
    func fetchPosts(page: Int)
    func postEntity(at index: Int) -> VideoEntity?
    func searchPosts(query: String)
    func createPost(video: VideoEntity)
}

protocol PostInteractorToPresenter: AnyObject {
    func didStartFetchingPosts()
    func didFetchPosts(_ posts: [VideoEntity], page: Int)
    func didFailToFetchPosts(_ error: Error)
    func didSearchPosts(_ posts: [VideoEntity])
    func didCreatePost(_ video: VideoEntity)
    func didFailToCreatePost(_ error: Error)
}

// MARK: - Router
protocol PostPresenterToRouter: AnyObject {
    func navigateToPlayer(from view: PostPresenterToView, with video: VideoEntity)
    func navigateToCreateForm(from view: PostPresenterToView?)
}
