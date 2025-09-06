//
//  WebViewDetailConfigurator.swift
//  WebViewDetail
//
//  Created by Abraham Putra Lukas on 05/09/25.
//

import UIKit

public final class WebViewDetailConfigurator {
    public static let shared = WebViewDetailConfigurator()
    public weak var delegate: WebViewDetailWireframe?

    public func createWebViewModule(url: URL, title: String) -> UIViewController {
        let view = WebViewDetailViewController()
        let presenter = WebViewDetailPresenter()
        let interactor = WebViewDetailInteractor()
        let router = WebViewDetailRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        presenter.url = url
        presenter.pageTitle = title

        return view
    }
}

