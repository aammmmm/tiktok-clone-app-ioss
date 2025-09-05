//
//  FeedWorkerProtocol.swift
//  FeedWorker
//
//  Created by Abraham Putra Lukas on 03/09/25.
//

import Core

public protocol FeedWorkerProtocol: AnyObject {
    var responseDelegate: FeedWorkerResponseProtocol? { get set }
    func fetchVideos(page: Int)
}

public protocol FeedWorkerResponseProtocol: AnyObject {
    func didSuccessFetchVideos(_ videos: [VideoEntity], page: Int)
    func didFailFetchVideos(error: String)
}

