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
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var liveBadgeLabel: UILabel!

//    @IBOutlet weak var overlayView: UIView!
    
    private let gradientLayer = CAGradientLayer()

//    inisiasi pada view setelah semua properti outlet sudah terhubung dari XIB
    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        overlayView?.layer.sublayers?.first?.frame = overlayView?.bounds ?? .zero
//    }

//    buat reuse cell, jadi clear data lama
//    kf bakal cancelDownloadTask untuk gbr lama, buat mencegah salah ambil gambar saat discroll cepat
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.kf.cancelDownloadTask()
        thumbnailImageView.image = nil
        liveBadgeLabel.isHidden = true
    }

//    buat configure cell
    func configure(with item: FeedEntity) {
        setupUI()
        
        titleLabel.text = item.title
        authorLabel.text = "\(item.author)  •  \(item.views) views"

        if let url = URL(string: item.thumbnailUrl) {
            // Tampilkan loading indicator
            thumbnailImageView.kf.indicatorType = .activity
            thumbnailImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "video_placeholder"),
                options: [.transition(.fade(0.2))]
            )
        } else {
            thumbnailImageView.image = UIImage(named: "video_placeholder")
        }

        liveBadgeLabel.isHidden = !item.isLive
    }

    private func setupUI() {
        contentView.backgroundColor = .systemBackground

        // Card
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 24
        containerView.layer.masksToBounds = false
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.10
        containerView.layer.shadowRadius = 12
        containerView.layer.shadowOffset = CGSize(width: 0, height: 8)

        thumbnailImageView.contentMode = .scaleToFill
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.cornerRadius = 24
//        thumbnailImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // hanya sudut atas

        // Gradient
//        overlayView.isUserInteractionEnabled = false
//        overlayView.backgroundColor = .clear
//        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.3).cgColor]
//        gradientLayer.locations = [0.0, 1.0]
//        overlayView.layer.insertSublayer(gradientLayer, at: 0)

        titleLabel.textColor = .black

        authorLabel.textColor = .secondaryLabel
        authorLabel.font = .systemFont(ofSize: 15)

        // LIVE chip
        liveBadgeLabel.text = "LIVE"
        liveBadgeLabel.textColor = .red
        liveBadgeLabel.backgroundColor = UIColor(red: 0.86, green: 0.21, blue: 0.27, alpha: 1.0)
        liveBadgeLabel.font = .boldSystemFont(ofSize: 12)
        liveBadgeLabel.layer.cornerRadius = 10
        liveBadgeLabel.clipsToBounds = true
        liveBadgeLabel.contentInset(top: 4, left: 10, bottom: 4, right: 10) 
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


