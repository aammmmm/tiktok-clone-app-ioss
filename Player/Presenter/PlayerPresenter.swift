//
//  PlayerPresenter.swift
//  Player
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Foundation
import Core
import UIKit

final class PlayerPresenter: PlayerViewToPresenter {

    weak var view: PlayerPresenterToView?
    var interactor: PlayerPresenterToInteractor?
    var router: PlayerPresenterToRouter?
    
    func viewDidLoad() {
        interactor?.fetchVideoDetails()
    }
    
    public func didTapWebButton(url: URL, title: String) {
        if let view = view {
            router?.navigateToWebDetail(from: view, url: url, title: title)
        }
    }
    
    
//    func didTapDummyButton() {
//        router?.navigateToNextPage(from: view)
//    }

}

extension PlayerPresenter: PlayerInteractorToPresenter {
    func didFetchVideoDetails(_ video: VideoEntity) {
        view?.showVideoDetails(video)
    }
    
    func didFailToFetchVideoDetails(_ error: Error) {
        view?.showError(error.localizedDescription)
    }
}
