//
//  OnboardViewController.swift
//  FakeStore
//
//  Created by leewonseok on 2023/04/01.
//

import UIKit

// 페이지 컨트롤 보기, 컴포지셔널 레이아웃 적용
// 컨트롤 커맨드 < > 열린 파일 이동
// 이미지 로딩 - 킹피셔
// 위로 떙겼을때 새로고침 - API다시
// DTO 모델 옵셔널 처리
// MVVM
// Rx


class OnBoardViewController: UIViewController{
    
    let pageControl = UIPageControl()
    let viewModel = OnBoardViewModel()
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let cellWidth = UIScreen.main.bounds.width - 16
        flowLayout.itemSize = CGSize(width: cellWidth, height: 500)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    @objc private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .colorWithHex(hex: 0xD2D2D2)
        button.layer.cornerRadius = 12
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.colorWithHex(hex: 0x204EC5), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        setConstarints()
        setPageControl()
        setCollectionView()
        setBindings()
    }
    
    private func setBindings() {
        let _ = loginButton.rx.tap.subscribe { [weak self] _  in
            let loginViewController = LoginViewController()
            self?.navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
}

// MARK: - Configure Method
extension OnBoardViewController {
    private func setPageControl() {
        pageControl.numberOfPages = viewModel.items.count
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OnBoardCell.self, forCellWithReuseIdentifier: OnBoardCell.identifier)
    }
    
    private func setUI() {
        [pageControl, collectionView, loginButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setConstarints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

// MARK: - CollectionView Method
extension OnBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardCell.identifier, for: indexPath) as? OnBoardCell else {
            return OnBoardCell()
        }
        
        cell.setData(data: viewModel.items[indexPath.item])
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / collectionView.frame.size.width)
        pageControl.currentPage = currentPage
    }
}
