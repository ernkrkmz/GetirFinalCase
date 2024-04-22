//
//  ListingInteractor.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 10.04.2024.
//

import Foundation

protocol ListingInteractorProtocol{
    func fetchVerticalScrollPosts()
    func fetchHorizontalScrollPosts()
}
protocol ListingInteractorOutputProtocol: AnyObject{
    func fetchVerticalScrollPosts(data : [VerticalProduct])
    func fetchHorizontalScrollPosts(data : [HorizontalProduct])
}

final class ListingInteractor {
    var output: ListingInteractorOutputProtocol?
}

extension ListingInteractor: ListingInteractorProtocol {
    func fetchVerticalScrollPosts() {
        let cardRepository = CardRepository()
        
    }
    
    func fetchHorizontalScrollPosts() {
        let cardRepository = CardRepository()
//        let cards = cardRepository.getHorizontalCardData() ?? [HorizontalProduct]()
//        self.output?.fetchHorizontalScrollPosts(data: cards)
    }
    
    
}
