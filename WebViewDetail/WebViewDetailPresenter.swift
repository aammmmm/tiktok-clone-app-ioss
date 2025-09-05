//
//  WebViewDetailPresenter.swift
//  WebViewDetail
//
//  Created by Abraham Putra Lukas on 04/09/25.
//

import Foundation


public final class WebViewDetailPresenter {
    public weak var view: WebViewDetailPresenterToView?
    public var router: WebViewDetailPresenterToRouter?
    public var interactor: WebViewDetailPresenterToInteractor?

    // dependency yang akan diisi di configurator
    public var url: URL?
    public var pageTitle: String?
}

extension WebViewDetailPresenter: WebViewDetailViewToPresenter {
    public func viewDidLoad() {
        guard let url = url, let title = pageTitle else { return }
        let request = URLRequest(url: url)
        view?.loadWebPage(request, title: title)
    }
    
    public func didTapNavigateToFeed() {
        if let view = view {
            router?.navigateToFeed(from: view)
        }
    }

    public func didTapPopToRoot() {
        if let view = view {
            router?.popToRoot(from: view)
        }
    }
}

extension WebViewDetailPresenter: WebViewDetailInteractorToPresenter {}

