//
//  DetailViewController.swift
//  FakeStore
//
//  Created by leewonseok on 2023/03/30.
//

import UIKit

class DetailViewController: UIViewController {
    private var imageUrl: String? {
        didSet {
            if let imageUrl {
                NetworkManager.fetchImage(urlString: imageUrl, completion: { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let image):
                            self.imageView.image = image
                        case .failure(_):
                            self.imageView.image = UIImage(systemName: "x.square")
                        }
                    }
                })
            }
        }
    }
    
    private var itemTitle: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    private var category: Category? {
        didSet {
            if let category {
                categoryLabel.text = "카테고리 : \(category.rawValue)"
            }
        }
    }
    
    private var rate: Double? {
        didSet {
            if let rate {
                rateLabel.text = "별점 \(rate)"
            }
        }
    }
    
    private var count: Int? {
        didSet {
            if let count {
                itemCountLabel.text = "상품구매수량 : \(count)"
            }
        }
    }
    
    private var content: String? {
        didSet {
            descriptionLabel.text = content
        }
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let rateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.layoutMargins = UIEdgeInsets(top: 20.5, left: 0, bottom: 20.5, right: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let rateImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star"))
        return imageView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorWithHex(hex: 0xEEEFF1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let itemCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .colorWithHex(hex: 0x6C6464)
        label.font = .systemFont(ofSize: 10)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        setConstariants()
    }
}

// MARK: - Coniguration Method
extension DetailViewController {
    func setData(item: Item) {
        itemTitle = item.title
        imageUrl = item.image
        category = item.category
        content = item.description
        count = item.rating.count
        rate = item.rating.rate
    }
    
    private func setUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [rateLabel, rateImageView].forEach {
            rateStackView.addArrangedSubview($0)
        }
        
        [imageView, titleLabel, rateStackView, lineView, categoryLabel, itemCountLabel, descriptionLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setConstariants() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.4),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -14),
            
            rateStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 19),
            rateStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rateStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            rateStackView.heightAnchor.constraint(equalToConstant: 60),
            
            
            lineView.topAnchor.constraint(equalTo: rateStackView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: rateStackView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: rateStackView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            categoryLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 12),
            categoryLabel.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            
            itemCountLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 12),
            itemCountLabel.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            itemCountLabel.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: itemCountLabel.bottomAnchor, constant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: itemCountLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: itemCountLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
