//
//  FeedRouter.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

// FeedRouter.swift
import UIKit
import Core

// createModule sebagai factory untuk assemble seluruh modulenya saat dipanggil di sceneDelegate, lalu return view yg siap pakai
public final class FeedRouter: FeedPresenterToRouter {
    public static func createModule() -> UIViewController {
        let view = FeedViewController(nibName: "FeedViewController", bundle: Bundle(for: FeedViewController.self))
        let presenter = FeedPresenter()
        let interactor = FeedInteractor()
        let router = FeedRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        return view
    }
    
    func navigateToPlayer(from view: FeedPresenterToView, with video: VideoEntity) {
        AppRouter.route?(.player(video))
    }

}

