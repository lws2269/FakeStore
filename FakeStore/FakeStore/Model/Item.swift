//
//  Item.swift
//  FakeStore
//
//  Created by leewonseok on 2023/03/30.
//

import Foundation

struct Item: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}
