//
//  PostRouter.swift
//  Post
//
//  Created by Abraham Putra Lukas on 31/08/25.
//

import UIKit
import Core

public final class PostRouter: PostPresenterToRouter {
    func navigateToPlayer(from view: PostPresenterToView, with video: VideoEntity) {
        AppRouter.route?(.player(video.id))
    }

    func navigateToCreateForm(from view: PostPresenterToView?) {
        let formVC = PostFormViewController() // form untuk create
        if let vc = view as? UIViewController {
            vc.navigationController?.pushViewController(formVC, animated: true)
        }
    }
}


