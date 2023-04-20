//
//  ItemCell.swift
//  FakeStore
//
//  Created by leewonseok on 2023/03/27.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    private var itemTitle: String? {
        didSet {
            titleLabel.text = itemTitle
        }
    }
    
    private var price: Double? {
        didSet {
            if let price {
                priceLabel.text = "$ \(price)"
            }
        }
    }
    
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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .colorWithHex(hex: 0x2B2B2B)
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .vertical)
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageUrl = nil
        itemTitle = nil
        price = nil
    }
    
    func setData(item: Item) {
        imageUrl = item.image
        itemTitle = item.title
        price = item.price
    }
    
    private func setUI() {
        [imageView, titleLabel, priceLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 230),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
