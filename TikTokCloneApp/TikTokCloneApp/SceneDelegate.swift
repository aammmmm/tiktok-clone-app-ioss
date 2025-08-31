//
//  SceneDelegate.swift
//  TikTokCloneApp
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import UIKit
import Core
import Feed
import Player

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        // set root view
        let feedVC = FeedRouter.createModule()
        let rootNavigationController = UINavigationController(rootViewController: feedVC)
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        // Routing setup
        AppRouter.route = { destination in
            print("DEBUG: Routing to \(destination)")
            switch destination {
            case .feed:
                print("DEBUG: Feed route triggered")
                let feedVC = FeedRouter.createModule()
                UIApplication.topViewController()?.navigationController?.pushViewController(feedVC, animated: true)
                
            case .player(let video):
                print("DEBUG: Video route triggered")
                let playerVC = PlayerRouter.createModule(with: video)
                UIApplication.topViewController()?.navigationController?.pushViewController(playerVC, animated: true)
            default:
                print("Route Not Found")
            }
        }
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

