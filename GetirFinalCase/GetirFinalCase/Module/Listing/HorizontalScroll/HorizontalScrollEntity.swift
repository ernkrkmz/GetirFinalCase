//
//  HorizontalScrollEntity.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 10.04.2024.
//

import Foundation

// MARK: - WelcomeElement
struct HorizontalWelcomeElement: Codable {
    //24 Nisan saat 01.00 Api den gelen veri değişti products'ı Optional olarak tanımlayınca sorun düzeldi
    let products: [HorizontalProduct]?
    let id, name: String?
}

// MARK: - Product
struct HorizontalProduct: Codable {
    let id: String
    let imageURL: String?
    let price: Double?
    let name, priceText: String?
    let shortDescription, category: String?
    let unitPrice: Double?
    let squareThumbnailURL: String?
    let status: Int?
}

typealias HorizontalWelcome = [HorizontalWelcomeElement]
