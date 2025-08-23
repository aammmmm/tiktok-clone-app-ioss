//
//  FeedRouter.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import UIKit
import Core

final public class FeedRouter: FeedViewToRouter {
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
    
    func navigateToPlayer(with video: VideoEntity, from view: UIViewController) {
        // nanti push ke Player module
        print("Navigate to Player with video: \(video.title)")
    }
}
