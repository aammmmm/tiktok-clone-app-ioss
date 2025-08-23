//
//  FeedTableCollectionViewCell.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 22/08/25.
//

import UIKit
import Kingfisher
import Core

final class FeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    func configure(with video: VideoEntity) {
        titleLabel.text = video.title
        authorLabel.text = video.author
        if let url = URL(string: video.thumbnailUrl) {
            thumbnailImageView.kf.setImage(with: url)
        } else {
            thumbnailImageView.image = nil
        }
    }
}

