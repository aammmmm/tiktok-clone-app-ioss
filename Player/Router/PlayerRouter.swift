//
//  PlayerRouter.swift
//  Player
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Foundation
import Core

public final class PlayerRouter: PlayerPresenterToRouter {
    public static func createModule(with video: VideoEntity) -> PlayerViewController {
        let view = PlayerViewController(
            nibName: "PlayerViewController",
            bundle: Bundle(for: PlayerViewController.self)
        )
        
        let presenter = PlayerPresenter()
        let interactor = PlayerInteractor(video: video)
        let router = PlayerRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
}
