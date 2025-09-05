//
//  FeedConfigurator.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 04/09/25.
//

import UIKit

public final class FeedConfigurator {
    public static let shared = FeedConfigurator()
    public var delegate: FeedWireframe?

    public func createFeedModule() -> UIViewController {
        let view = FeedViewController(nibName: "FeedViewController", bundle: Bundle(for: FeedViewController.self))
        let presenter = FeedPresenter()
        let interactor = FeedInteractor()
        let router = FeedRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.output = presenter

        return view
    }
}
