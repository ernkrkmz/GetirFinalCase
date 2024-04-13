//
//  CardRepository.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 10.04.2024.
//

import Foundation

protocol CardRepositoryProtocol {
    func getHorizontalCardData() -> [HorizontalProduct]?
    func getVerticalCardData() -> [VerticalProduct]?
}

final class CardRepository: CardRepositoryProtocol {
    
    // TODO: get data
    func getHorizontalCardData() -> [HorizontalProduct]? {
        return nil
    }
    
    func getVerticalCardData() -> [VerticalProduct]? {
        return nil
    }
    
    
    
}
