//
//  PlayerPresenter.swift
//  Player
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Foundation
import Domain
import UIKit

class PlayerPresenter: PlayerViewToPresenter {
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
}

extension PlayerPresenter: PlayerInteractorToPresenter {
    func didFetchVideoDetails(_ video: VideoEntity) {
        view?.showVideoDetails(video)
    }
    
    func didFailToFetchVideoDetails(_ error: APIErrorResponse) {
        let appError = AppError(apiError: error)
        
        if error.error.code == 4993 {
            view?.showWebViewError(appError)
        } else if error.error.code == 8000 {
            view?.showError(appError)
        }
    }
}
