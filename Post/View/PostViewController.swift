//
//  PostViewController.swift
//  Post
//
//  Created by Abraham Putra Lukas on 31/08/25.
//

import UIKit
import Kingfisher
import Core

final class PostViewController: UIViewController, PostPresenterToView {
    var presenter: PostViewToPresenter?
    
    static let nibName = "PostCollectionViewCell"
    static let reuseIdentifier = "PostCollectionViewCell"
    
    private var collectionView: UICollectionView!
    private var posts: [VideoEntity] = []
    private var isLoadingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 248/255, alpha: 1)
        setupCollectionView()
        setupNavigationBar()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 14, bottom: 16, right: 14)
        layout.minimumLineSpacing = 24
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let nib = UINib(nibName: "PostCollectionViewCell", bundle: Bundle(for: PostViewController.self))
        collectionView.register(nib, forCellWithReuseIdentifier: "PostCollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupNavigationBar() {
        title = "Post"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAdd)
        )
    }
    
//    declare nav modal sheet
    @objc private func didTapAdd() {
        let formVC = PostFormViewController()
        formVC.onSubmit = { [weak self] video in
            self?.presenter?.didTapCreate(video: video)
        }
        let nav = UINavigationController(rootViewController: formVC)
        nav.modalPresentationStyle = .pageSheet
        present(nav, animated: true)
    }
    
    func showPosts(_ posts: [VideoEntity]) {
        self.posts = posts
        collectionView.reloadData()
    }
    
    func appendPosts(_ posts: [VideoEntity]) {
        let start = self.posts.count
        self.posts.append(contentsOf: posts)
        let end = self.posts.count
        let indexPaths = (start..<end).map { IndexPath(item: $0, section: 0) }
        
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: indexPaths)
        }
    }
    
    func showLoading(_ isLoading: Bool) {
        isLoadingMore = isLoading
        collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


extension PostViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PostCollectionViewCell",
            for: indexPath
        ) as? PostCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: posts[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 28
        let height: CGFloat = 280
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height,
           !isLoadingMore {
            presenter?.loadMorePosts()
        }
    }
}
