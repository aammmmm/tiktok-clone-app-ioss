//
//  PostProtocols.swift
//  Post
//
//  Created by Abraham Putra Lukas on 31/08/25.
//

import UIKit
import Domain

protocol PostViewToPresenter: AnyObject {
    func viewDidLoad()
    func loadMorePosts()
    func didSelectItem(at index: Int)
    func didTapCreate(request: CreatePostRequest)
    func didPullToRefresh()
}

protocol PostPresenterToView: AnyObject {
    func showLoading(_ show: Bool)
    func showPosts(_ posts: [VideoEntity])
    func appendPosts(_ posts: [VideoEntity])
    func showError(_ message: String)
}

protocol PostPresenterToInteractor: AnyObject {
    func fetchPosts(page: Int)
    func createPost(request: CreatePostRequest)
}

protocol PostInteractorToPresenter: AnyObject {
    func didFetchPosts(_ posts: [VideoEntity], page: Int)
    func didFailToFetchPosts(_ error: String)
    func didCreatePost(_ video: VideoEntity)
    func didFailToCreatePost(_ error: String)
}

protocol PostPresenterToRouter: AnyObject {
    func navigateToPlayer(from view: PostPresenterToView, with videoId: String)
}
