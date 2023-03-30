//
//  ListViewController.swift
//  FakeStore
//
//  Created by leewonseok on 2023/03/27.
//

import UIKit

class ListViewController: UIViewController {
    let manager = NetworkManager()
    var items: [Item]? {
        didSet {
            DispatchQueue.main.async {
                self.spinnerView.isHidden = true
                self.itemCountLabel.text = "\(self.items?.count ?? 0)개의 상품"
                self.sortStackView.isHidden = false
                self.collectionView.reloadData()
            }
        }
    }
    
    let spinnerView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .gray
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let itemCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .colorWithHex(hex: 0x696B72)
        return label
    }()
    
    private let sortStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
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
        fetchItemAll()
    }
    
    private func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
    }
    
    private func fetchItemAll() {
        spinnerView.startAnimating()
        
        let urlString = "https://fakestoreapi.com/products"
        
        manager.fetchItemAll(urlString: urlString) { result in
            switch result {
            case .success(let items):
                self.items = items
            case .failure(_):
                break
            }
        }
    }
}

// MARK: - CollectionView Method
extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else {
            return ItemCell()
        }
        let item = items?[indexPath.item]
        cell.setData(title: item?.title, price: item?.price, imageURL: item?.image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
        
        [labelStackView, collectionView, spinnerView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
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
