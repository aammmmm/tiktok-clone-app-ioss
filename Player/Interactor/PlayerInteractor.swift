//
//  PlayerInteractor.swift
//  Player
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Foundation
import Core

final class PlayerInteractor: PlayerPresenterToInteractor {
    weak var presenter: PlayerInteractorToPresenter?
    private let video: VideoEntity
    
    init(video: VideoEntity) {
        self.video = video
    }
    
    func fetchVideoDetails() {
        presenter?.didFetchVideoDetails(video)
    }
}
