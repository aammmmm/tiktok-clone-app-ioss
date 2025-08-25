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
    var router: FeedViewToRouter?

    private var page = 1
    private var isLoading = false
}

extension FeedPresenter: FeedViewToPresenter {
    func viewDidLoad() {
        isLoading = true
        page = 1
        view?.showLoading(true)
        interactor?.fetchVideos(page: page)
    }

    func loadMoreVideos() {
        guard !isLoading else { return }
        isLoading = true
        page += 1
        interactor?.fetchVideos(page: page)
    }

    func didSelectItem(at index: Int) {
        guard let video = interactor?.videoEntity(at: index),
              let vc = view as? UIViewController else { return }
        router?.navigateToPlayer(with: video, from: vc)
    }
}

extension FeedPresenter: FeedInteractorToPresenter {
    func didFetchVideos(_ videos: [FeedEntity], page: Int) {
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

