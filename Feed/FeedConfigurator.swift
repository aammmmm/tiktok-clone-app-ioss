//
//  FeedConfigurator.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 04/09/25.
//

import UIKit

public final class FeedConfigurator {
    public static func createFeedModule() -> UIViewController {
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
}
