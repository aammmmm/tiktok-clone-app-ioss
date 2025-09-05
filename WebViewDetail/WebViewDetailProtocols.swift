//
//  WebViewDetailProtocols.swift
//  WebViewDetail
//
//  Created by Abraham Putra Lukas on 05/09/25.
//


public protocol WebViewDetailPresenterToView: AnyObject {
    func loadWebPage(_ request: URLRequest, title: String)
}

public protocol WebViewDetailViewToPresenter: AnyObject {
    func viewDidLoad()
    func didTapNavigateToFeed()
    func didTapPopToRoot()
}

public protocol WebViewDetailPresenterToInteractor: AnyObject {

}

public protocol WebViewDetailInteractorToPresenter: AnyObject {
    
}

public protocol WebViewDetailPresenterToRouter: AnyObject {
    func navigateToFeed(from view: WebViewDetailPresenterToView)
    func popToRoot(from view: WebViewDetailPresenterToView)
}
