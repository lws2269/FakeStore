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
    
    let name: PublishSubject<String>
    let password: PublishSubject<String>
    
    let validatedname: Observable<Bool>
    let validatedPassword: Observable<Bool>
    
    init(name: PublishSubject<String>, password: PublishSubject<String>, validatedname: Observable<Bool>, validatedPassword: Observable<Bool>) {
        
        self.name = name
        self.password = password
        
        self.validatedname = validatedname
        self.validatedPassword = validatedPassword
    }
    
}
