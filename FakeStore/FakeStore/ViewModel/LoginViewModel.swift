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
    let validatedName: Observable<Bool>
    let validatedPassword: Observable<Bool>
    let isLoginEnabled: Observable<Bool>
    let isPasswordHidden: BehaviorRelay<Bool>
    
    init(input: (
            name: Observable<String>,
            password: Observable<String>,
            loginTap: Observable<Void>
        )
    ) {
        isPasswordHidden = .init(value: true)
        
        validatedName = input.name.map {
            return $0.count > 0
        }
        
        validatedPassword = input.password.map {
            return $0.count > 0
        }
        
        isLoginEnabled = Observable
            .combineLatest(validatedName, validatedPassword)
            .map { !([$0,$1].contains(false)) }
    }
    
}

