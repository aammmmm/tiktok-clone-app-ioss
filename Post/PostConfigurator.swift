//
//  PostConfigurator.swift
//  Post
//
//  Created by Abraham Putra Lukas on 04/09/25.
//

import UIKit

public final class PostConfigurator {
    public static func createModule() -> UIViewController {
        let view = PostViewController()
        let presenter = PostPresenter()
        let interactor = PostInteractor()
        let router = PostRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter

        return view
    }
}
