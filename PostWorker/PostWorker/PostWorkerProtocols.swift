//
//  PostWorkerProtocols.swift
//  PostWorker
//
//  Created by Abraham Putra Lukas on 07/09/25.
//

import Domain

public protocol PostWorkerProtocol: AnyObject {
    var responseDelegate: PostWorkerResponseProtocol? { get set }
    func fetchPosts(page: Int)
    func createPost(request: CreatePostRequest)
}

// MARK: PostWorkerResponseProtocol
public protocol PostWorkerResponseProtocol: AnyObject {
    func didSuccessFetchPosts(_ posts: [VideoEntity], page: Int)
    func didFailFetchPosts(error: String)
    func didSuccessCreatePost(_ video: VideoEntity)
    func didFailCreatePost(error: String)
}
