//
//  FeedProtocols.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import UIKit
import Core

protocol FeedViewToPresenter: AnyObject {
    func viewDidLoad()
    func loadMoreVideos()
    func didSelectItem(at index: Int)
}

protocol FeedPresenterToView: AnyObject {
    func showVideos(_ videos: [FeedEntity])
    func appendVideos(_ videos: [FeedEntity])
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
}

protocol FeedPresenterToInteractor: AnyObject {
    func fetchVideos(page: Int)
    func videoEntity(at index: Int) -> VideoEntity?   // ambil dari cache
}

protocol FeedInteractorToPresenter: AnyObject {
    func didStartFetchingVideos()
    func didFetchVideos(_ videos: [FeedEntity], page: Int)
    func didFailToFetchVideos(_ error: Error)
}

protocol FeedPresenterToRouter: AnyObject {
    func navigateToPlayer(from view: FeedPresenterToView, with video: VideoEntity)
}

// ViewToPresenter -> PresenterToInteractor -> InteractorToPresenter -> PresenterToView -> PresenterToRouter
