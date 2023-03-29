//
//  ListViewController.swift
//  FakeStore
//
//  Created by leewonseok on 2023/03/27.
//

import UIKit

class ListViewController: UIViewController {
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let itemCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "14개의 상품"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .colorWithHex(hex: 0x696B72)
        return label
    }()
    
    private let sortStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let sortLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .colorWithHex(hex: 0x696B72)
        label.text = "최신순"
        return label
    }()
    
    private let sortImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        imageView.tintColor = .colorWithHex(hex: 0x696B72)
        return imageView
    }()
    
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cellWidth = (UIScreen.main.bounds.width - 50) / 2
        flowLayout.itemSize = CGSize(width: cellWidth, height: 300)
        flowLayout.minimumInteritemSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNaviBar()
        setUI()
        setConstraints()
        setCollectionView()
    }
    
    private func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
    }
}

// MARK: - CollectionView Method
extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else {
            return ItemCell()
        }
        return cell
    }
}

// MARK: - Coniguration Method
extension ListViewController {
    private func setNaviBar() {
        navigationItem.title = "상품목록"
    }
    
    private func setUI() {
        [sortLabel, sortImageView].forEach {
            sortStackView.addArrangedSubview($0)
        }
        
        [itemCountLabel, sortStackView].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        [labelStackView, collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            labelStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 20),
            collectionView.leftAnchor.constraint(equalTo: labelStackView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: labelStackView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
