//
//  Identifiable.swift
//  FakeStore
//
//  Created by leewonseok on 2023/04/10.
//

import UIKit

protocol Identifiable {
    static var identifier : String { get }
}

extension Identifiable {
    static var identifier : String {
      return String(describing: Self.self)
    }
}

extension UICollectionViewCell : Identifiable {}
