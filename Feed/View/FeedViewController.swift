//
//  FeedViewController.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 21/08/25.
//

import UIKit
import Core

class FeedViewController: UIViewController, FeedPresenterToView {
    var presenter: FeedViewToPresenter?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var videos: [FeedEntity] = []   // <- pakai FeedEntity

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        view.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 248/255, alpha: 1)
        collectionView.backgroundColor = .clear
        presenter?.viewDidLoad()
    }

    private func setupCollectionView() {
        let nib = UINib(nibName: "FeedTableCollectionViewCell", bundle: Bundle(for: FeedViewController.self))
        collectionView.register(nib, forCellWithReuseIdentifier: "FeedTableCollectionViewCell")

        collectionView.dataSource = self
        collectionView.delegate = self

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
               layout.scrollDirection = .vertical
               layout.minimumLineSpacing = 16
               layout.minimumInteritemSpacing = 0
               layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 24, right: 16)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let inset = layout.sectionInset.left + layout.sectionInset.right
            let width = collectionView.bounds.width - inset
            let thumbHeight = width * 9 / 16
            let textBlockHeight: CGFloat = 100 // title + author
            layout.itemSize = CGSize(width: width, height: thumbHeight + textBlockHeight)
        }
    }

    // MARK: - FeedPresenterToView
    func showVideos(_ videos: [FeedEntity]) {
        self.videos = videos
        collectionView.reloadData()
    }

    func appendVideos(_ newItems: [FeedEntity]) {
        let start = videos.count
        videos.append(contentsOf: newItems)
        let end = videos.count
        let indexPaths = (start..<end).map { IndexPath(item: $0, section: 0) }
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: indexPaths)
        }
    }

    func showLoading(_ isLoading: Bool) { }
    func showError(_ message: String) { }
}

extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // count video di collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videos.count
    }
    
//    isi cell sesuai indexPath.item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FeedTableCollectionViewCell", for: indexPath
        ) as? FeedCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: videos[indexPath.item])
        return cell
    }

//    navigate ke detail lewat presenter -> router
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath.item)
    }

//    infinite scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.bounds.height
        if offsetY > contentHeight - height * 2 {
            presenter?.loadMoreVideos()
        }
    }
}


