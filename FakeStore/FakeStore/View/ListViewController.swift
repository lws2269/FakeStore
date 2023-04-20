//
//  ListViewController.swift
//  FakeStore
//
//  Created by leewonseok on 2023/03/27.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture

class ListViewController: UIViewController {
    let disposeBag: DisposeBag = .init()
    let viewModel: ListViewModel = .init()
    
    private let toTopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.tintColor = .colorWithHex(hex: 0xD9D9D9)
        button.backgroundColor = .white
        button.layer.cornerRadius = 22
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let sortTextField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.backgroundColor = .colorWithHex(hex: 0xF7F7F7)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()
    
    private let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private let spinnerView: UIActivityIndicatorView = {
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
        stackView.isUserInteractionEnabled = true
        stackView.isHidden = true
        return stackView
    }()
    
    private let sortLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .colorWithHex(hex: 0x696B72)
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
        setSortTextField()
        setCollectionView()
        setBindings()
    }
    
    private func setBindings() {
        // 로딩 상태에 따른 스피너와 스택뷰 숨김처리
        viewModel.isLoading
            .map { !$0 }
            .bind(to: spinnerView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .bind(to: sortStackView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // items가 변경되면, Label의 값 변경
        viewModel.items
            .map {
                "\($0.count)개의 상품"
            }
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        // items에 따른 컬렉션뷰 설정 - DataSource
        viewModel.items
            .bind(to: collectionView.rx.items(cellIdentifier: ItemCell.identifier, cellType: ItemCell.self)) { row, item, cell in
                cell.setData(item: item)
            }
            .disposed(by: disposeBag)
        
        // 컬렉션 뷰가 선택되면 행해질 로직 - Delegate
        collectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                guard let self = self else { return }
                let detailViewController = DetailViewController()
                let item = self.viewModel.items.value[indexPath.item]
                detailViewController.setData(item: item)
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        // SortText가 변경됨에 따른 sortLabel 변경
        viewModel.sortText
            .drive(sortLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 위로가기 버튼 클릭시 처리될 로직
        toTopButton.rx.tap
            .subscribe { [weak self] _ in
                self?.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
            .disposed(by: disposeBag)
        
        // 스택 뷰(sort에 대한)가 선택되면 처리할 로직
        sortStackView.rx.tapGesture()
            .when(.recognized)
            .subscribe { [weak self] _ in
                self?.sortTextField.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
    }
}
// MARK: - Action
extension ListViewController {
    @objc private func sortDoneButtonTapped() {
        self.view.endEditing(true)
    }
}

// MARK: - PickerView Method
extension ListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.sortList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(viewModel.sortList[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.sortState.accept(SortType(rawValue: row) ?? .desc)
    }
}

// MARK: - Coniguration Method
extension ListViewController {
    private func setNaviBar() {
        navigationItem.title = "상품목록"
    }
    
    private func setSortTextField() {
        let barButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(sortDoneButtonTapped))
        toolbar.setItems([barButton], animated: true)
        pickerView.delegate = self
        pickerView.dataSource = self
        sortTextField.inputAccessoryView = toolbar
        sortTextField.inputView = pickerView
    }
    
    private func setUI() {
        [sortLabel, sortImageView].forEach {
            sortStackView.addArrangedSubview($0)
        }
        
        [itemCountLabel, sortStackView].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        [labelStackView, collectionView, spinnerView, sortTextField, toTopButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setCollectionView() {
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            labelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: labelStackView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: labelStackView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            toTopButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            toTopButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            toTopButton.heightAnchor.constraint(equalToConstant: 44),
            toTopButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
}
