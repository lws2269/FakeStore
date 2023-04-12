//
//  ItemCell.swift
//  FakeStore
//
//  Created by leewonseok on 2023/03/27.
//

import UIKit

class OnBoardCell: UICollectionViewCell {
    static let identifier = ItemCell.description()
    
    private var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    private var content: String? {
        didSet {
            contentLabel.text = content
        }
    }
    
    private var image: UIImage? {
        didSet {
            imageView.image = image
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
        label.textColor = .colorWithHex(hex: 0x878787)
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .vertical)
        label.font = .boldSystemFont(ofSize: 34)
        label.numberOfLines = 3
        label.textColor = .colorWithHex(hex: 0x12348A)
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
        title = nil
        content = nil
        image = nil
    }
    
    func setData(data: (title: String, content: String, image: UIImage)) {
        self.title = data.title
        self.content = data.content
        self.image = data.image
    }
    
    private func setUI() {
        [imageView, titleLabel, contentLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
    }
}
