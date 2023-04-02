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
    
    private let contentLabel: UILabel = {
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
        imageUrl = nil
        title = nil
        content = nil
    }
    
    func setData(imageUrl: String, title: String, content: String) {
    }
    
    private func setUI() {
        [imageView, titleLabel, contentLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
}
