//
//  ListingPresenter.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 10.04.2024.
//

import Foundation

protocol ListingPresenterProtocol: AnyObject {
    func viewDidLoad()
   
}
final class ListingPresenter {
    unowned var view : ListingViewController
    let router : ListingRouterProtocol
    let interactor: ListingInteractorProtocol
    
    var horizontalCards: [HorizontalProduct] = []
    var verticalCards: [VerticalProduct] = []
    
    init(view: ListingViewController, router: ListingRouterProtocol, interactor: ListingInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        
    }
}

extension ListingPresenter: ListingPresenterProtocol {
    func viewDidLoad() {
        view.setupNavigationBar()
        view.setupHorizontalScrollView()
        view.setupVerticalScrollView()
    }
    
    
}
