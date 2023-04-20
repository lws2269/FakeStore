//
//  LoginViewModel.swift
//  FakeStore
//
//  Created by leewonseok on 2023/04/16.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewModel {
    let disposeBag: DisposeBag = .init()
    
    let inputName: BehaviorRelay<String> = .init(value: "")
    let inputPassword: BehaviorRelay<String> = .init(value: "")
    let isLoginEnabled: BehaviorRelay<Bool> = .init(value: false)
    let isPasswordHidden: BehaviorRelay<Bool> = .init(value: true)
    
    init() {
        setBindings()
    }
    
    private func setBindings() {
        Observable.combineLatest(inputName, inputPassword)
            .map {
                [$0.count > 0, $1.count > 0].contains(false)
            }.subscribe {
                self.isLoginEnabled.accept(!$0)
            }.disposed(by: disposeBag)
    }
    
}

