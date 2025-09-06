//
//  Navigations.swift
//  AppNavigations
//
//  Created by Abraham Putra Lukas on 05/09/25.
//

import UIKit
import Feed
import Player
import WebViewDetail

// atur navigasi secara global dengan menyambungkan configurator, dan navigate
// Navigations jadi delegate dari semua config, yaitu terima semua navigation request
public class Navigations {
    
    public static let shared = Navigations()
    
//    menghubungkan configurator dengan Navigations, init jadi delegate untuk semua config yg ada
    private init() {
//        bilg ke config "object navigations adlh delegate mu, setiap kamu perlu navigate, berikan ke aku
        FeedConfigurator.shared.delegate = self
        PlayerConfigurator.shared.delegate = self
        WebViewDetailConfigurator.shared.delegate = self
    }

    public func buildFeedModule() -> UIViewController {
        return FeedConfigurator.shared.createFeedModule()
    }
}

extension Navigations: FeedWireframe {
    public func fromFeedToPlayer(view: UIViewController, videoId: String) {
        let playerVC = PlayerConfigurator.shared.createPlayerModule(with: videoId)
        view.navigationController?.pushViewController(playerVC, animated: true)
    }
}

extension Navigations: PlayerWireframe {
    public func fromPlayerToWebViewDetail(view: UIViewController, url: URL, title: String) {
        let webVC = WebViewDetailConfigurator.shared.createWebViewModule(url: url, title: title)
        view.navigationController?.pushViewController(webVC, animated: true)
    }
}

extension Navigations: WebViewDetailWireframe {
    public func fromWebDetailToFeed(view: UIViewController) {
        let feedVC = buildFeedModule()
        view.navigationController?.pushViewController(feedVC, animated: true)
    }
    
    public func fromWebDetailPopToRoot(view: UIViewController) {
        view.navigationController?.popToRootViewController(animated: true)
    }
}
