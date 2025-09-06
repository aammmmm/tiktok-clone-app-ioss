//
//  FeedRouter.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import UIKit

public final class FeedRouter: FeedPresenterToRouter {
    func navigateToPlayer(from view: FeedPresenterToView, with videoId: String) {
        guard let vc = view as? UIViewController else { return }
        FeedConfigurator.shared.delegate?.fromFeedToPlayer(view: vc, videoId: videoId)
    }
}

