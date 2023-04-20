//
//  DetailViewModel.swift
//  FakeStore
//
//  Created by leewonseok on 2023/04/20.
//

import UIKit
import RxCocoa
import RxSwift

class DetailViewModel {
    let item: BehaviorRelay<Item>
    let image: Driver<UIImage>
    
    init(item: Item) {
        self.item = BehaviorRelay(value: item)
        image = NetworkManager.fetchImageRx(urlString: item.image)
            .asDriver(onErrorJustReturn: UIImage(systemName: "x.square")!)
    }
}
