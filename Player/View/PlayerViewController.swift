//
//  PlayerViewController.swift
//  Player
//
//  Created by Abraham Putra Lukas on 25/08/25.
//

import UIKit
import WebKit
import Core

public class PlayerViewController: UIViewController {
    var presenter: PlayerViewToPresenter?
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var uploadTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var subscriberLabel: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func configureWebView() {
        let config = webView.configuration
        config.allowsInlineMediaPlayback = true
        if #available(iOS 10.0, *) {
            config.mediaTypesRequiringUserActionForPlayback = []
        } else {
            config.requiresUserActionForMediaPlayback = false
        }

        webView.backgroundColor = .black
        webView.isOpaque = false
        
//        buang constraint lama
        if let layout = webView.superview?.constraints.first(where: { $0.firstAttribute == .height && $0.secondAttribute == .width }) {
            layout.isActive = false
        }
        let aspectRatio = NSLayoutConstraint(item: webView as Any, attribute: .height, relatedBy: .equal, toItem: webView, attribute: .width, multiplier: 9.0/16.0, constant: 0)
        aspectRatio.isActive = true
    }
    
    private func setupUI() {
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        
        viewsLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        viewsLabel.textColor = .systemGray
        
        authorLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        uploadTimeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        uploadTimeLabel.textColor = .systemGray
        
        durationLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        durationLabel.textColor = .systemGray
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        subscriberLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subscriberLabel.textColor = .systemGray
    }
}

extension PlayerViewController: PlayerPresenterToView {
    func showVideoDetails(_ video: VideoEntity) {
        title = video.title

        titleLabel.text = video.title
        authorLabel.text = video.author
        viewsLabel.text = "\(video.views) views"
        uploadTimeLabel.text = video.uploadTime
        durationLabel.text = video.duration
        descriptionLabel.text = video.description
        subscriberLabel.text = video.subscriber

        if let url = URL(string: video.videoUrl) {
            webView.load(URLRequest(url: url))
        }
    }
}

