//
//  WebViewDetailViewController.swift
//  WebViewDetail
//
//  Created by Abraham Putra Lukas on 05/09/25.
//

import UIKit
import WebKit

public class WebViewDetailViewController: UIViewController {
    public var presenter: WebViewDetailViewToPresenter?

    private let webView = WKWebView()
    private let navigateToFeedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Navigate to Feed", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let popToRootButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pop to Root", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupButtons()
        presenter?.viewDidLoad()
    }

    private func setupWebView() {
        view.backgroundColor = .systemBackground
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }

    private func setupButtons() {
        view.addSubview(navigateToFeedButton)
        view.addSubview(popToRootButton)

        NSLayoutConstraint.activate([
            navigateToFeedButton.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 16),
            navigateToFeedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            popToRootButton.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 16),
            popToRootButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        navigateToFeedButton.addTarget(self, action: #selector(didTapNavigateToFeed), for: .touchUpInside)
        popToRootButton.addTarget(self, action: #selector(didTapPopToRoot), for: .touchUpInside)
    }

    @objc private func didTapNavigateToFeed() {
        presenter?.didTapNavigateToFeed()
    }

    @objc private func didTapPopToRoot() {
        presenter?.didTapPopToRoot()
    }
}

extension WebViewDetailViewController: WebViewDetailPresenterToView {
    public func loadWebPage(_ request: URLRequest, title: String) {
        self.title = title
        webView.load(request)
    }
}

