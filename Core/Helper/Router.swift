//
//  Router.swift
//  Core
//
//  Created by Abraham Putra Lukas on 25/08/25.
//

import Foundation

public enum AppRoute {
    case feed
    case player(VideoEntity)
}

public class AppRouter {
    public static var route: ((AppRoute) -> Void)?
}

