//
//  OnboardViewController.swift
//  FakeStore
//
//  Created by leewonseok on 2023/04/01.
//

import UIKit

class OnBoardViewController: UIViewController{
    // 페이지 컨트롤
    let pageControl = UIPageControl()
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    
    private let loginButton: UIButton = {
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
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = 5
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setCollectionView() {
        
    }
    
    private func setUI() {
        view.addSubview(pageControl)
    }
    
    private func setConstarints() {
        NSLayoutConstraint.activate([
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}
