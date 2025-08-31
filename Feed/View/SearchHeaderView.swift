//
//  SearchHeaderView.swift
//  Feed
//
//  Created by Abraham Putra Lukas on 30/08/25.
//

import UIKit

protocol SearchHeaderViewDelegate: AnyObject {
    func didSubmitSearch(query: String)
}

final class SearchHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SearchHeaderView"

    weak var delegate: SearchHeaderViewDelegate?

    private let searchField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search..."
        tf.borderStyle = .roundedRect
        tf.returnKeyType = .search
        return tf
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchField)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            searchField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])

        searchField.delegate = self
        searchField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func textDidChange(_ textField: UITextField) {
        // ❌ Tidak menutup keyboard, hanya update presenter kalau mau real-time
        // Kalau hanya search saat submit, baris ini bisa dihapus
    }
}

extension SearchHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let query = textField.text ?? ""
        delegate?.didSubmitSearch(query: query)
        textField.resignFirstResponder() // ✅ Keyboard baru ditutup saat user tekan Search
        return true
    }
}
