//
//  VerticalScrollEntity.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 10.04.2024.
//

import Foundation


// MARK: - WelcomeElement
struct VerticalWelcomeElement: Codable {
    let id, name: String?
    let productCount: Int?
    let products: [VerticalProduct]?
}

// MARK: - Product
struct VerticalProduct: Codable {
    let id, name: String?
    let attribute: String?
    let thumbnailURL, imageURL: String?
    let price: Double?
    let priceText: String?
    let shortDescription: String?
    
    
}

typealias VerticalWelcome = [VerticalWelcomeElement]


