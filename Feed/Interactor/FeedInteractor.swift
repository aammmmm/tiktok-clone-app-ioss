//
//  FeedInteractor.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//


// FeedInteractor.swift
import Foundation
import Core
import Moya

final class FeedInteractor: FeedPresenterToInteractor {
    weak var output: FeedInteractorToPresenter?
    private let provider = MoyaProvider<APIProviders>()
    private var cache: [VideoEntity] = []

    func fetchVideos(page: Int) {
        provider.request(.getVideos) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let videos = try JSONDecoder().decode([VideoEntity].self, from: response.data)
                    if page == 1 { self.cache = videos } else { self.cache.append(contentsOf: videos) }
                    self.output?.didFetchVideos(FeedEntityMapper.mapList(videos), page: page)
                } catch { self.output?.didFailToFetchVideos(error) }
            case .failure(let error):
                self.output?.didFailToFetchVideos(error)
            }
        }
    }

    func videoEntity(at index: Int) -> VideoEntity? {
        guard index >= 0 && index < cache.count else { return nil }
        return cache[index]
    }
}


