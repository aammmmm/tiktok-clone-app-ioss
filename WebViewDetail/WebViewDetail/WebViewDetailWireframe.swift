//
//  WebViewDetailWireframe.swift
//  WebViewDetail
//
//  Created by Abraham Putra Lukas on 05/09/25.
//

import UIKit

public protocol WebViewDetailWireframe: AnyObject {
    func fromWebDetailToFeed(view: UIViewController)
    func fromWebDetailPopToRoot(view: UIViewController)
}
