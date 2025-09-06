//
//  FeedPresenter.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Core

final class FeedPresenter {
    weak var view: FeedPresenterToView?
    var interactor: FeedPresenterToInteractor?
    var router: FeedPresenterToRouter?

    private var page = 1
    private var isLoading = false
    private var isSearching = false
    private var videosCache: [VideoEntity] = []
    private var searchResults: [VideoEntity] = []
}

extension FeedPresenter: FeedViewToPresenter {
    func viewDidLoad() {
        page = 1
        interactor?.fetchVideos(page: page)
    }

    func loadMoreVideos() {
        guard !isLoading, !isSearching else { return }
        isLoading = true
        page += 1
        print("DEBUG: loadMoreVideos called, page=\(page)")
        interactor?.fetchVideos(page: page)
    }

    func didSelectItem(at index: Int) {
        let targetList = isSearching ? searchResults : videosCache
        let video = targetList[index]
        if let view = view {
            router?.navigateToPlayer(from: view, with: video.id)
        }
    }

    func didTapSearch(query: String) {
        if query.isEmpty {
            isSearching = false
            view?.clearVideos()
            page = 1
            interactor?.fetchVideos(page: page)
        } else {
            isSearching = true
            searchResults = videosCache.filter {
                $0.title.lowercased().contains(query.lowercased()) ||
                $0.author.lowercased().contains(query.lowercased())
            }
            let feedEntities = FeedEntityMapper.mapList(searchResults)
            view?.showVideos(feedEntities)
        }
    }
}

extension FeedPresenter: FeedInteractorToPresenter {
    func didStartFetchingVideos() {
        view?.showLoading(true)
    }
    
    func didFetchVideos(_ videos: [VideoEntity], page: Int) {
        print("DEBUG: didFetchVideos called, page=\(page), count=\(videos.count)")
        isLoading = false
        view?.showLoading(false)

        if page == 1 {
            videosCache = videos
            let feedEntities = FeedEntityMapper.mapList(videosCache)
            view?.showVideos(feedEntities)
        } else {
            videosCache.append(contentsOf: videos)
            let newEntities = FeedEntityMapper.mapList(videos)
            view?.appendVideos(newEntities)
        }
    }

    func didFailToFetchVideos(_ error: Error) {
        isLoading = false
        view?.showLoading(false)
        view?.showError(error.localizedDescription)
    }
}
