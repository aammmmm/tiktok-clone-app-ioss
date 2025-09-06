//
//  PlayerWorkerProtocol.swift
//  PlayerWorker
//
//  Created by Abraham Putra Lukas on 04/09/25.
//

import Core

public protocol PlayerWorkerProtocol {
    var responseDelegate: PlayerWorkerResponseDelegate? { get set }
    func fetchVideoDetail(by id: String)
}

public protocol PlayerWorkerResponseDelegate: AnyObject {
    func didSuccessFetchVideoDetail(_ video: VideoEntity)
    func didFailFetchVideoDetail(error: APIErrorResponse)
}
