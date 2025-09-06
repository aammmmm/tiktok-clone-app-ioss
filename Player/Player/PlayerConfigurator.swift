//
//  PlayerConfigurator.swift
//  Player
//
//  Created by Abraham Putra Lukas on 04/09/25.
//
import Core
import UIKit

public final class PlayerConfigurator {
    public static let shared = PlayerConfigurator()
    public var delegate: PlayerWireframe?
    
    public func createPlayerModule(with videoId: String) -> UIViewController {
        let view = PlayerViewController(
            nibName: "PlayerViewController",
            bundle: Bundle(for: PlayerViewController.self)
        )
        
        let presenter = PlayerPresenter()
        let interactor = PlayerInteractor(videoId: videoId)
        let router = PlayerRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
