//
//  FeedProtocols.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import UIKit
import Domain

protocol FeedViewToPresenter: AnyObject {
    func viewDidLoad()
    func loadMoreVideos()
    func didSelectItem(at index: Int)
    func didTapSearch(query: String)
}

protocol FeedPresenterToView: AnyObject {
    func showVideos(_ videos: [FeedEntity])
    func appendVideos(_ videos: [FeedEntity])
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
    func clearVideos()
}

protocol FeedPresenterToInteractor: AnyObject {
    func fetchVideos(page: Int)
}

protocol FeedInteractorToPresenter: AnyObject {
    func didFetchVideos(_ videos: [VideoEntity], page: Int)
    func didFailToFetchVideos(_ error: String)
}

protocol FeedPresenterToRouter: AnyObject {
    func navigateToPlayer(from view: FeedPresenterToView, with video: String)
}
