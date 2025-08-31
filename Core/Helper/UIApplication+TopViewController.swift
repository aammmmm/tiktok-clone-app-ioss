//
//  UIApplication+TopViewController.swift
//  Core
//
//  Created by Abraham Putra Lukas on 25/08/25.
//

import UIKit

// helper class untuk nemuin VC yg aktif (top view), supaya navigasi atau push bisa dilakuin
extension UIApplication {
    public static func topViewController(
        _ base: UIViewController? = UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.rootViewController
    ) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
