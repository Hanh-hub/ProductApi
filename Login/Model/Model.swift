//
//  Model.swift
//  Login
//
//  Created by Hanh Vo on 6/9/23.
//

import Foundation
// LoginRequestModel.swift
struct LoginRequestModel: Codable {
    let username: String
    let password: String
}

// UserModel.swift
struct UserModel: Codable {
    let id: Int?
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: String
    let token: String
}


struct ProductResponse: Codable {
    let products: [Product]
}

struct Product: Codable, Hashable {
    let id: Int
    let title: String?
    let description: String?
    let price: Double?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
}


