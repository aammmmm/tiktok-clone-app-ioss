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
import Post

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let feedVC = FeedRouter.createModule()
        let feedNav = UINavigationController(rootViewController: feedVC)
        feedNav.tabBarItem = UITabBarItem(title: "Feed",
                                          image: UIImage(systemName: "house"),
                                          tag: 0)

        let postVC = PostRouter.createModule()
        let postNav = UINavigationController(rootViewController: postVC)
        postNav.tabBarItem = UITabBarItem(title: "Post",
                                          image: UIImage(systemName: "plus.square"),
                                          tag: 1)

        let profileVC = UIViewController()
        profileVC.view.backgroundColor = .systemBackground
        profileVC.title = "Profile"
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile",
                                             image: UIImage(systemName: "person"),
                                             tag: 2)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [feedNav, postNav, profileNav]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        AppRouter.route = { destination in
            switch destination {
            case .feed:
                tabBarController.selectedIndex = 0
            case .post:
                tabBarController.selectedIndex = 1
            case .player(let video):
                let playerVC = PlayerRouter.createModule(with: video)
                UIApplication.topViewController()?.navigationController?.pushViewController(playerVC, animated: true)
            default:
                print("Route Not Found")
            }
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


