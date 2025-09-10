//
//  FeedInteractor.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Foundation
import Domain
import FeedWorker

class FeedInteractor: FeedPresenterToInteractor {
    weak var presenter: FeedInteractorToPresenter?
    private let worker: FeedWorkerr

//    interactor sebagai delegate dari worker, worker menggunakan interactor sebagai delegatenya
    init(worker: FeedWorkerr = FeedWorkerr()) {
        self.worker = worker
        self.worker.responseDelegate = self
    }

    func fetchVideos(page: Int) {
        worker.fetchVideos(page: page)
    }
}

extension FeedInteractor: FeedWorkerResponseProtocol {
    func didSuccessFetchVideos(_ videos: [VideoEntity], page: Int) {
        presenter?.didFetchVideos(videos, page: page)
    }

    func didFailFetchVideos(error: String) {
        presenter?.didFailToFetchVideos(error)
    }
}
