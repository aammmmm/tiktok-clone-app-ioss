//
//  PostFormViewController.swift
//  Post
//
//  Created by Abraham Putra Lukas on 01/09/25.
//

import UIKit
import Core

final class PostFormViewController: UIViewController {
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    
    private let titleField = UITextField()
    private let thumbnailField = UITextField()
    private let durationField = UITextField()
    private let uploadTimeField = UITextField()
    private let viewsField = UITextField()
    private let authorField = UITextField()
    private let videoUrlField = UITextField()
    private let descriptionField = UITextView()
    private let subscriberField = UITextField()
    private let isLiveSwitch = UISwitch()
    private let submitButton = UIButton(type: .system)
    
    // Callback ke parent
    var onSubmit: ((VideoEntity) -> Void)?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Add Video"
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.axis = .vertical
        contentView.spacing = 12
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        // Tambahkan field
        addTextField(titleField, placeholder: "Title")
        addTextField(thumbnailField, placeholder: "Thumbnail URL")
        addTextField(durationField, placeholder: "Duration")
        addTextField(uploadTimeField, placeholder: "Upload Time")
        addTextField(viewsField, placeholder: "Views")
        addTextField(authorField, placeholder: "Author")
        addTextField(videoUrlField, placeholder: "Video URL")
        
        let descLabel = UILabel()
        descLabel.text = "Description"
        descLabel.font = .systemFont(ofSize: 14, weight: .medium)
        contentView.addArrangedSubview(descLabel)
        
        descriptionField.layer.borderColor = UIColor.lightGray.cgColor
        descriptionField.layer.borderWidth = 1
        descriptionField.layer.cornerRadius = 6
        descriptionField.heightAnchor.constraint(equalToConstant: 100).isActive = true
        contentView.addArrangedSubview(descriptionField)
        
        addTextField(subscriberField, placeholder: "Subscriber")
        
        let liveStack = UIStackView(arrangedSubviews: [
            UILabel(text: "Is Live:"), isLiveSwitch
        ])
        liveStack.axis = .horizontal
        liveStack.spacing = 8
        contentView.addArrangedSubview(liveStack)
        
        // Submit button
        submitButton.setTitle("Submit", for: .normal)
        submitButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        contentView.addArrangedSubview(submitButton)
    }
    
    private func addTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        contentView.addArrangedSubview(textField)
    }
    
    // MARK: - Actions
    @objc private func handleSubmit() {
        let video = VideoEntity(
            id: UUID().uuidString,
            title: titleField.text ?? "",
            thumbnailUrl: thumbnailField.text ?? "",
            duration: durationField.text ?? "",
            uploadTime: uploadTimeField.text ?? "",
            views: viewsField.text ?? "",
            author: authorField.text ?? "",
            videoUrl: videoUrlField.text ?? "",
            description: descriptionField.text,
            subscriber: subscriberField.text ?? "",
            isLive: isLiveSwitch.isOn
        )
        
        onSubmit?(video)
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - UILabel Convenience
private extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
    }
}
