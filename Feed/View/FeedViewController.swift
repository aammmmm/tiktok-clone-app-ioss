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
    
    private var videos: [FeedEntity] = []
    private var isLoadingMore = false
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter?.viewDidLoad()
    }

    private func setupCollectionView() {
        let nib = UINib(nibName: FeedCollectionViewCell.nibName, bundle: Bundle(for: FeedViewController.self))
        
        collectionView.register(nib, forCellWithReuseIdentifier: FeedCollectionViewCell.reuseIdentifier)
        collectionView.register(LoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingFooterView.reuseIdentifier)
        collectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchHeaderView.reuseIdentifier
        )

        view.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 248/255, alpha: 1)
        collectionView.backgroundColor = .clear
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .always
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }

    // load data pertama kali / refresh
    func showVideos(_ videos: [FeedEntity]) {
        self.videos = videos
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }

//    buat append data saat discroll ke view (pagination)
    func appendVideos(_ newItems: [FeedEntity]) {
        let start = videos.count
        videos.append(contentsOf: newItems)
        let end = videos.count
        let indexPaths = (start..<end).map { IndexPath(item: $0, section: 0) }
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: indexPaths)
        }
        print("Start: \(start)")
        print("End: \(end)")
        print("Index Paths: \(indexPaths)")
    }

    func showLoading(_ isLoading: Bool) {
        isLoadingMore = isLoading
        collectionView.reloadSections(IndexSet(integer: 0))
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Refresh", style: .default, handler: { _ in
            self.presenter?.viewDidLoad()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
    @objc private func didPullToRefresh() {
        videos.removeAll()
        collectionView.reloadData()
        isLoadingMore = false

        presenter?.viewDidLoad()
    }
    
    func clearVideos() {
        self.videos = []
        collectionView.reloadData()
        collectionView.setContentOffset(.zero, animated: false)
    }
    
//    func showOriginalVideos() {
//        // Cukup panggil reloadData() tanpa memodifikasi self.videos
//        // karena self.videos masih menyimpan data asli.
//        collectionView.reloadData()
//    }
    
}

extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SearchHeaderViewDelegate {
    
    // count berapa banyak video per section untuk CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videos.count
    }

    // isi cell sesuai indexPath.item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FeedCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? FeedCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: videos[indexPath.item])
        return cell
    }

    // navigate to player
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath.item)
    }

    // header & footer (search bar + loading spinner)
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath
     ) -> UICollectionReusableView {
         if kind == UICollectionView.elementKindSectionHeader {
             guard let header = collectionView.dequeueReusableSupplementaryView(
                 ofKind: kind,
                 withReuseIdentifier: SearchHeaderView.reuseIdentifier,
                 for: indexPath
             ) as? SearchHeaderView else {
                 return UICollectionReusableView()
             }
             header.delegate = self
             return header
         }

         if kind == UICollectionView.elementKindSectionFooter {
             guard let footer = collectionView.dequeueReusableSupplementaryView(
                 ofKind: kind,
                 withReuseIdentifier: LoadingFooterView.reuseIdentifier,
                 for: indexPath
             ) as? LoadingFooterView else {
                 return UICollectionReusableView()
             }
             isLoadingMore ? footer.startAnimating() : footer.stopAnimating()
             return footer
         }

         return UICollectionReusableView()
     }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return isLoadingMore ? CGSize(width: collectionView.bounds.width, height: 60) : .zero
    }
    
//    cell (coll card) size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        margin
        let width = collectionView.bounds.width - 28
        let height: CGFloat = 280
        return CGSize(width: width, height: height)
    }
    
//    cell spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height,
           !isLoadingMore {
            presenter?.loadMoreVideos()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 56)
    }
    
//    jarak antar header ke cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    func didSubmitSearch(query: String) {
        presenter?.didTapSearch(query: query)
    }
}
