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
    
    private var videos: [VideoEntity] = []

//    lifecycle, jalan otomatis saat render
        override func viewDidLoad() {
            super.viewDidLoad()
            setupCollectionView()
            presenter?.viewDidLoad()
        }

//    FeedVC jadi dataSource dan delegate untuk collectionView
    private func setupCollectionView() {
        let nib = UINib(nibName: "FeedTableCollectionViewCell", bundle: Bundle(for: FeedViewController.self))
        collectionView.register(nib, forCellWithReuseIdentifier: "FeedTableCollectionViewCell")

        // Data source & delegate
        collectionView.dataSource = self
        collectionView.delegate = self

        // Layout: FlowLayout (list style)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = .init(top: 8, left: 0, bottom: 8, right: 0)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //  item == lebar collection
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = collectionView.bounds.width
            layout.itemSize = CGSize(width: width - 0, height: 180)
        }
    }

    // MARK: - FeedPresenterToView
    func showVideos(_ videos: [VideoEntity]) {
        self.videos = videos
        collectionView.reloadData()
    }

    func appendVideos(_ newItems: [VideoEntity]) {
        let start = videos.count
        videos.append(contentsOf: newItems)
        let end = videos.count
        let indexPaths = (start..<end).map { IndexPath(item: $0, section: 0) }
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: indexPaths)
        })
    }

    func showLoading(_ isLoading: Bool) {  }

    func showError(_ message: String) {  }
}

// MARK: - DataSource & Delegate
extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videos.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FeedTableCollectionViewCell", for: indexPath
        ) as? FeedCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: videos[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectVideo(videos[indexPath.item])
    }

    // Infinite scroll (threshold 2 item dari bawah)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.bounds.height
        if offsetY > contentHeight - height * 2 {
            presenter?.loadMoreVideos()
        }
    }

}
