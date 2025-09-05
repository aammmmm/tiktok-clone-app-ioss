//
//  PlayerConfigurator.swift
//  Player
//
//  Created by Abraham Putra Lukas on 04/09/25.
//
import Core

public class PlayerConfigurator {
    public static func createModule(with videoId: String) -> PlayerViewController {
        let view = PlayerViewController(
            nibName: "PlayerViewController",
            bundle: Bundle(for: PlayerViewController.self)
        )
        
        let presenter = PlayerPresenter()
        let interactor = PlayerInteractor(videoId: videoId)
        let router = PlayerRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}


