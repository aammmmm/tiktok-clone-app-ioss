//
//  PlayerPresenter.swift
//  Player
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Foundation
import Core

final class PlayerPresenter: PlayerViewToPresenter {

    weak var view: PlayerPresenterToView?
    var interactor: PlayerPresenterToInteractor?
    var router: PlayerPresenterToRouter?
    
    func viewDidLoad() {
        interactor?.fetchVideoDetails()
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
