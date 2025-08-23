//
//  FeedInteractor.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//


import Foundation
import Core
import Moya

final class FeedInteractor: FeedPresenterToInteractor {
    weak var output: FeedInteractorToPresenter?
    private let provider = MoyaProvider<APIProviders>()
    
    func fetchVideos(page: Int) {
        provider.request(.getVideos) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    let videos = try JSONDecoder().decode([VideoEntity].self, from: response.data)
                    self.output?.didFetchVideos(videos)
                } catch {
                    self.output?.didFailToFetchVideos(error)
                }
                
            case .failure(let error):
                self.output?.didFailToFetchVideos(error)
            }
        }
    }
}

