//
//  PostWireframe.swift
//  Post
//
//  Created by Abraham Putra Lukas on 08/09/25.
//

import UIKit

public protocol PostWireframe: AnyObject {
    func fromPostToPlayer(view: UIViewController, videoId: String)
}
