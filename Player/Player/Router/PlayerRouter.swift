//
//  PlayerRouter.swift
//  Player
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import Foundation
import Core
import UIKit

public final class PlayerRouter: PlayerPresenterToRouter {
    func navigateToWebDetail(from view: PlayerPresenterToView, url: URL, title: String) {
        guard let vc = view as? UIViewController else { return }
        PlayerConfigurator.shared.delegate?.fromPlayerToWebViewDetail(view: vc, url: url, title: title
        )
    }
    
//    func navigateToNextPage(from view: (any PlayerPresenterToView)?) {
//        guard let sourceVC = view as? UIViewController else { return }
//        let nextVC = NextViewController(nibName: NextViewController.nibName, bundle: Bundle(for: NextViewController.self))
//        sourceVC.navigationController?.pushViewController(nextVC, animated: true)
//    }
}
