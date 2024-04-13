//
//  ListingRouter.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 10.04.2024.
//

import Foundation
enum ListingRoutes {
    case productDetail
    case Basket
}

protocol ListingRouterProtocol : AnyObject{
    func navigate(_ route: ListingRoutes)
}

final class ListingRouter {
    
    weak var ViewController: ListingViewController?
    
    static func createModule() -> ListingViewController {
        let view = ListingViewController()
        let interactor = ListingInteractor()
        let router = ListingRouter()
        
        let presenter = ListingPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = (presenter as! any ListingInteractorOutputProtocol) // ????
        router.ViewController = view
        
        return view
    }
}

extension ListingRouter: ListingRouterProtocol {
    func navigate(_ route: ListingRoutes) {
//        switch route{
//        case .productDetail:
//            let productDetailVC =
//        }
    }
    
    
}


