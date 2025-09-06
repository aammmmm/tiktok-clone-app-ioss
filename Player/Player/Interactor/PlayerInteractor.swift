//
//  PlayerInteractor.swift
//  Player
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Foundation
import Core
import PlayerWorker

final class PlayerInteractor: PlayerPresenterToInteractor {
    weak var presenter: PlayerInteractorToPresenter?
    private let videoId: String
    private let worker: PlayerWorkerr
    
    init(videoId: String, worker: PlayerWorkerr = PlayerWorkerr()) {
        self.videoId = videoId
        self.worker = worker
        self.worker.responseDelegate = self
    }
    
    func fetchVideoDetails() {
        worker.fetchVideoDetail(by: videoId)
    }
}

extension PlayerInteractor: PlayerWorkerResponseDelegate {
    func didSuccessFetchVideoDetail(_ video: VideoEntity) {
        presenter?.didFetchVideoDetails(video)
    }
    
    func didFailFetchVideoDetail(error: APIErrorResponse) {
//        let err = NSError(domain: "FeedWorker", code: -1, userInfo: [NSLocalizedDescriptionKey: error])
        presenter?.didFailToFetchVideoDetails(error)
    }
}

