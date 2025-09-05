//
//  FeedRouter.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

// FeedRouter.swift
import UIKit
import Core

public final class FeedRouter: FeedPresenterToRouter {
    func navigateToPlayer(from view: FeedPresenterToView, with videoId: String) {
        print("Video ID: \(videoId)")
        AppRouter.route?(.player(videoId))
    }
}

