//
//  FeedRouter.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

// FeedRouter.swift
import UIKit
import Core

public final class FeedRouter: FeedViewToRouter {
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

    public func navigateToPlayer(with video: VideoEntity, from view: UIViewController) {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBackground
        vc.title = video.title
        view.navigationController?.pushViewController(vc, animated: true)
    }
}

