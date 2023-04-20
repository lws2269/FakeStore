//
//  OnBoardViewModel.swift
//  FakeStore
//
//  Created by leewonseok on 2023/04/19.
//

import UIKit
import RxSwift
import RxCocoa

class OnBoardViewModel {
    let items: BehaviorRelay<[(String, String, UIImage)]> = .init(value: [])
    
    init () {
        items.accept([
            ("Welcome to PpakCoding", "신선한 과일", UIImage(named: "pageA")!),
            ("Welcome to PpakCoding", "Spend smarter every day, all from one app.", UIImage(named: "pageB")!),
            ("Welcome to PpakCoding", "Safe and secure international ppak-coding deep dive", UIImage(named: "pageC")!)
        ])
    }
}
