//
//  FeedPresenter.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

// FeedPresenter.swift
import UIKit
import Core

final class FeedPresenter {
    weak var view: FeedPresenterToView?
    var interactor: FeedPresenterToInteractor?
    var router: FeedPresenterToRouter?

    private var page = 1
    private var isLoading = false
}

extension FeedPresenter: FeedViewToPresenter {
    func viewDidLoad() {
        page = 1
        interactor?.fetchVideos(page: page)
    }

//    triggered saat scroll abis, lalu fetch
    func loadMoreVideos() {
        guard !isLoading else {
            return
        }
        isLoading = true
        page += 1
        print("DEBUG: loadMoreVideos called, page=\(page)")
        interactor?.fetchVideos(page: page)
    }

    func didSelectItem(at index: Int) {
        guard let video = interactor?.videoEntity(at: index),
                let view = view else { return }
        
        router?.navigateToPlayer(from: view, with: video)
    }
}

extension FeedPresenter: FeedInteractorToPresenter {
//    buat trigger showLoading saat scroll
    func didStartFetchingVideos() {
        view?.showLoading(true)
    }
    
    func didFetchVideos(_ videos: [FeedEntity], page: Int) {
        print("DEBUG: didFetchVideos called, page=\(page), count=\(videos.count)")
        isLoading = false
        view?.showLoading(false)
        if page == 1 { view?.showVideos(videos) } else { view?.appendVideos(videos) }
    }

    func didFailToFetchVideos(_ error: Error) {
        isLoading = false
        view?.showLoading(false)
        view?.showError(error.localizedDescription)
    }
}

