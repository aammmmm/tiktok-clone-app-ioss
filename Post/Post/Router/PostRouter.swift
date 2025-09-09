//
//  PostRouter.swift
//  Post
//
//  Created by Abraham Putra Lukas on 31/08/25.
//

import UIKit

public class PostRouter: PostPresenterToRouter {
    func navigateToPlayer(from view: PostPresenterToView, with videoId: String) {
        guard let vc = view as? UIViewController else { return }
        PostConfigurator.shared.delegate?.fromPostToPlayer(view: vc, videoId: videoId)
    }
        
    func navigateToCreateForm(from view: PostPresenterToView?) {
        let formVC = PostFormViewController()
        if let vc = view as? UIViewController {
            vc.navigationController?.pushViewController(formVC, animated: true)
        }
    }
}



