//
//  FeedInteractor.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Foundation
import Core
import FeedWorker


final class FeedInteractor: FeedPresenterToInteractor {
    weak var output: FeedInteractorToPresenter?
    private let worker: FeedWorkerr

    init(worker: FeedWorkerr = FeedWorkerr()) {
        self.worker = worker
        self.worker.responseDelegate = self
    }

    func fetchVideos(page: Int) {
        output?.didStartFetchingVideos()
        worker.fetchVideos(page: page)
    }
}

extension FeedInteractor: FeedWorkerResponseProtocol {
    func didSuccessFetchVideos(_ videos: [VideoEntity], page: Int) {
        output?.didFetchVideos(videos, page: page)
    }

    func didFailFetchVideos(error: String) {
        let err = NSError(domain: "FeedWorker", code: -1, userInfo: [NSLocalizedDescriptionKey: error])
        output?.didFailToFetchVideos(err)
    }
}
