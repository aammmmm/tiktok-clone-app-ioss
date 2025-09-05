//
//  PlayerWireframe.swift
//  Player
//
//  Created by Abraham Putra Lukas on 05/09/25.
//

import UIKit

public protocol PlayerWireframe: AnyObject {
    func fromPlayerToWebViewDetail(view: UIViewController, url: URL, title: String)
}
