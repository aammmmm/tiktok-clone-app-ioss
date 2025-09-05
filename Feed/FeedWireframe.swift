//
//  FeedWireframe.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 05/09/25.
//

import UIKit

// abstraksi berupa protocol
public protocol FeedWireframe: AnyObject {
    func fromFeedToPlayer(view: UIViewController, videoId: String)
}
