//
//  FeedInteractor.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Foundation
import Core
import Moya
import DataService

final class FeedInteractor: FeedPresenterToInteractor {
    weak var output: FeedInteractorToPresenter?
    private var cache: [VideoEntity] = []
    private var isFetching = false

    // MARK: - Fetch Videos (API + Cache)
    func fetchVideos(page: Int) {
        output?.didStartFetchingVideos()
//        closure ini pake weak untuk mencegah reference cycle, jadi weak memastikan self ga nambah itungan reference (self nyimpen closure, closure nyimpen self)
//        logic
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            APIService.shared.request(.getVideos) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    print(response.data)
                    do {
                        let videos = try JSONDecoder().decode([VideoEntity].self, from: response.data)
                        if page == 1 {
                            self.cache = videos
                        } else {
                            self.cache.append(contentsOf: videos)
                        }
                        self.output?.didFetchVideos(FeedEntityMapper.mapList(videos), page: page)
                    } catch {
                        self.output?.didFailToFetchVideos(error)
                    }
                case .failure(let error):
                    self.output?.didFailToFetchVideos(error)
                }
            }
        }
    }

//    ngambil video atau data by index
    func videoEntity(at index: Int) -> VideoEntity? {
        guard index >= 0 && index < cache.count else { return nil }
        return cache[index]
    }
    
    func searchVideos(query: String) {
        let results = cache.filter { video in
            video.title.lowercased().contains(query.lowercased())
            || video.author.lowercased().contains(query.lowercased())
        }
        output?.didSearchVideos(FeedEntityMapper.mapList(results))
    }
}
