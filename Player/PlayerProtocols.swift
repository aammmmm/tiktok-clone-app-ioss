//
//  PlayerProtocols.swift
//  Player
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Foundation
import Core

protocol PlayerViewToPresenter: AnyObject {
    func viewDidLoad()
}

protocol PlayerPresenterToView: AnyObject {
    func showVideoDetails(_ video: VideoEntity)
    func showError(_ message: String)
}

protocol PlayerPresenterToInteractor: AnyObject {
    func fetchVideoDetails()
}

protocol PlayerInteractorToPresenter: AnyObject {
    func didFetchVideoDetails(_ video: VideoEntity)
    func didFailToFetchVideoDetails(_ error: Error)
}

protocol PlayerPresenterToRouter: AnyObject {
//    static func createModule(with video: VideoEntity) -> PlayerViewController
//    func navigateToNextPage(from view: PlayerPresenterToView?)
}
