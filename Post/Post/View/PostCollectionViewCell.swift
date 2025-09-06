//
//  PostCollectionViewCell.swift
//  Post
//
//  Created by Abraham Putra Lukas on 01/09/25.
//

import UIKit
import Kingfisher
import Core

public final class PostCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PostCollectionViewCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var liveBadgeLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    private let gradientLayer = CAGradientLayer()

//    buat reuse cell, jadi clear data lama
//    kf bakal cancelDownloadTask untuk gbr lama, buat mencegah salah ambil gambar saat discroll cepat
    override public func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.kf.cancelDownloadTask()
        thumbnailImageView.image = nil
        liveBadgeLabel.isHidden = true
    }

//    buat configure cell
//    setImage utk download gbr, tampilin placeholder, cache, update img setelah selesai diload
    public func configure(with item: VideoEntity) {
        setupUI()
        
        titleLabel.text = item.title
        authorLabel.text = "\(item.author)  •  \(item.views) views"
        
        if let url = URL(string: item.thumbnailUrl) {
            thumbnailImageView.kf.indicatorType = .activity
            thumbnailImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "video_placeholder"),
                options: [.transition(.fade(0.2)), .cacheOriginalImage]
            )
        } else {
            thumbnailImageView.image = UIImage(named: "video_placeholder")
        }
        
        liveBadgeLabel.isHidden = !item.isLive
    }

    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 24
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.10
        containerView.layer.shadowRadius = 12
        containerView.layer.shadowOffset = CGSize(width: 0, height: 8)

        thumbnailImageView.layer.cornerRadius = 24
        thumbnailImageView.clipsToBounds = true
        
        titleLabel.textColor = .black
        authorLabel.textColor = .secondaryLabel
        authorLabel.font = .systemFont(ofSize: 15)

        liveBadgeLabel.text = "LIVE"
        liveBadgeLabel.textColor = .white
        liveBadgeLabel.backgroundColor = UIColor(red: 0.86, green: 0.21, blue: 0.27, alpha: 1.0)
        liveBadgeLabel.font = .boldSystemFont(ofSize: 12)
        liveBadgeLabel.layer.cornerRadius = 10
        liveBadgeLabel.clipsToBounds = true
        liveBadgeLabel.isHidden = true
    }
}

// UILabel padding helper
private extension UILabel {
    func contentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        let pad = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        let bg = UIView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        superview?.insertSubview(bg, belowSubview: self)
        bg.backgroundColor = backgroundColor
        backgroundColor = .clear
        bg.layer.cornerRadius = layer.cornerRadius
        bg.clipsToBounds = true
    }
}


