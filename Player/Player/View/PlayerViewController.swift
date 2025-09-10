//
//  PlayerViewController.swift
//  Player
//
//  Created by Abraham Putra Lukas on 25/08/25.
//

import UIKit
import WebKit
import Domain

public class PlayerViewController: UIViewController {
    var presenter: PlayerViewToPresenter?
    private var currentVideo: VideoEntity?

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var uploadTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var subscriberLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    
    private lazy var errorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Refresh", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(didTapRefreshButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        setupUI()
        setupErrorView()
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

        if let layout = webView.superview?.constraints.first(where: {
            $0.firstAttribute == .height && $0.secondAttribute == .width }) {
            layout.isActive = false
        }
    }
    
    private func setupUI() {
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        titleLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTitle))
        titleLabel.addGestureRecognizer(tapGesture)

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
    
    private func setupErrorView() {
        webView.addSubview(errorView)
        errorView.addSubview(errorMessageLabel)
        errorView.addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: webView.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: webView.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: webView.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: webView.bottomAnchor),
            
            errorMessageLabel.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            errorMessageLabel.centerYAnchor.constraint(equalTo: errorView.centerYAnchor, constant: -30),
            errorMessageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: errorView.leadingAnchor, constant: 20),
            errorMessageLabel.trailingAnchor.constraint(lessThanOrEqualTo: errorView.trailingAnchor, constant: -20),
            
            refreshButton.topAnchor.constraint(equalTo: errorMessageLabel.bottomAnchor, constant: 20),
            refreshButton.centerXAnchor.constraint(equalTo: errorView.centerXAnchor)
        ])
        
        errorView.isHidden = true
        }
    
    @objc private func didTapTitle() {
        guard let video = currentVideo,
              let url = URL(string: video.videoUrl) else { return }
        presenter?.didTapWebButton(url: url, title: video.title)
        print("TITLE IS CLICKED")
    }
    
    @objc private func didTapRefreshButton() {
        presenter?.viewDidLoad()
    }
}

extension PlayerViewController: PlayerPresenterToView {
    func showError(_ error: AppError) {
        let alert = UIAlertController(
            title: error.title,
            message: "\(error.message) (\(error.code))",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Refresh", style: .default, handler: { _ in
            self.presenter?.viewDidLoad()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    func showWebViewError(_ error: AppError) {
        webView.isHidden = false
        errorView.isHidden = false
        errorMessageLabel.text = "\(error.message) (\(error.code))"
        
        titleLabel.text = error.title
        authorLabel.text = ""
        viewsLabel.text = ""
        uploadTimeLabel.text = ""
        durationLabel.text = ""
        descriptionLabel.text = ""
        subscriberLabel.text = ""
        authorImageView.isHidden = true
    }

    func showVideoDetails(_ video: VideoEntity) {
        currentVideo = video   // simpan biar bisa dipakai saat tap
        title = video.title
        
        errorView.isHidden = true

        titleLabel.text = video.title
        authorLabel.text = video.author
        viewsLabel.text = "\(video.views) views"
        uploadTimeLabel.text = video.uploadTime
        durationLabel.text = video.duration
        descriptionLabel.text = video.description
        subscriberLabel.text = video.subscriber
        authorImageView.isHidden = false

        if let url = URL(string: video.videoUrl) {
            webView.load(URLRequest(url: url))
        }
    }
}
