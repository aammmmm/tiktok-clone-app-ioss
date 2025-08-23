//
//  FeedProtocols.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import UIKit
import Core

// MARK: - View
protocol FeedPresenterToView: AnyObject {
    func showVideos(_ videos: [VideoEntity])
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
}

//ViewToPresenter -> dipanggil dari view, ada di presenter
// MARK: - Presenter
protocol FeedViewToPresenter: AnyObject {
    func viewDidLoad()
    func loadMoreVideos()
    func didSelectVideo(_ video: VideoEntity)
}

// MARK: - Interactor
protocol FeedPresenterToInteractor: AnyObject {
    func fetchVideos(page: Int)
}

protocol FeedInteractorToPresenter: AnyObject {
    func didFetchVideos(_ videos: [VideoEntity])
    func didFailToFetchVideos(_ error: Error)
}

// MARK: - Router
protocol FeedViewToRouter: AnyObject {
    func navigateToPlayer(with video: VideoEntity, from view: UIViewController)
}
