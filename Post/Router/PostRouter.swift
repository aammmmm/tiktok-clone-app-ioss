//
//  PostRouter.swift
//  Post
//
//  Created by Abraham Putra Lukas on 31/08/25.
//

import UIKit
import Core

public final class PostRouter: PostPresenterToRouter {
    
    public static func createModule() -> UIViewController {
        let view = PostViewController()
        let presenter = PostPresenter()
        let interactor = PostInteractor()
        let router = PostRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter

        return view
    }

    func navigateToPlayer(from view: PostPresenterToView, with video: VideoEntity) {
        AppRouter.route?(.player(video))
    }

    func navigateToCreateForm(from view: PostPresenterToView?) {
        let formVC = PostFormViewController() // form untuk create
        if let vc = view as? UIViewController {
            vc.navigationController?.pushViewController(formVC, animated: true)
        }
    }
}


