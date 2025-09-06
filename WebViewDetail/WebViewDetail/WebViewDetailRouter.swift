//
//  WebViewDetailRouter.swift
//  WebViewDetail
//
//  Created by Abraham Putra Lukas on 04/09/25.
//

import UIKit

public final class WebViewDetailRouter: WebViewDetailPresenterToRouter {
    public func navigateToFeed(from view: WebViewDetailPresenterToView) {
        guard let vc = view as? UIViewController else { return }
        WebViewDetailConfigurator.shared.delegate?.fromWebDetailToFeed(view: vc)
    }

    public func popToRoot(from view: WebViewDetailPresenterToView) {
        guard let vc = view as? UIViewController else { return }
        WebViewDetailConfigurator.shared.delegate?.fromWebDetailPopToRoot(view: vc)
    }
}

