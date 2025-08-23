//
//  FeedPresenter.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Foundation
import Core
import UIKit

final class FeedPresenter: FeedViewToPresenter {
    weak var view: FeedPresenterToView?
    var interactor: FeedPresenterToInteractor?
    var router: FeedViewToRouter?
    
    private var currentPage = 1
    private var videos: [VideoEntity] = []
    
    func viewDidLoad() {
        view?.showLoading(true)
        interactor?.fetchVideos(page: currentPage)
    }
    
    func loadMoreVideos() {
        currentPage += 1
        interactor?.fetchVideos(page: currentPage)
    }
    
    func didSelectVideo(_ video: VideoEntity) {
        if let vc = view as? UIViewController {
            router?.navigateToPlayer(with: video, from: vc)
        }
    }
}

extension FeedPresenter: FeedInteractorToPresenter {
    func didFetchVideos(_ videos: [VideoEntity]) {
        view?.showLoading(false)
        self.videos.append(contentsOf: videos)
        view?.showVideos(self.videos)
    }
    
    func didFailToFetchVideos(_ error: Error) {
        view?.showLoading(false)
        view?.showError(error.localizedDescription)
    }
}
