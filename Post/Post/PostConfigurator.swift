//
//  PostConfigurator.swift
//  Post
//
//  Created by Abraham Putra Lukas on 04/09/25.
//

import UIKit

public class PostConfigurator {
    public static let shared = PostConfigurator()
    public var delegate: PostWireframe?
    
    public func createPostModule() -> UIViewController {
        let view = PostViewController(nibName: "PostViewController", bundle: Bundle(for: PostViewController.self))
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
