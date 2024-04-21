//
//  CardRepository.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 10.04.2024.
//

import Foundation
import Alamofire

protocol CardRepositoryProtocol {
    func getHorizontalCardData() -> [HorizontalProduct]? 
    func getVerticalCardData() -> [VerticalProduct]?
}

final class CardRepository: CardRepositoryProtocol {
    
    func haberleriIndir (url : URL , completion : @escaping ([HorizontalWelcomeElement]?) -> () ){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data {
                
                let data = try? JSONDecoder().decode([HorizontalWelcomeElement].self, from: data)
                
                if let data = data {
                    completion(data)
                }
                
            }
        }.resume()
    }
    
    // TODO: get data
    func getHorizontalCardData() -> [HorizontalProduct]? {
        let realURL = URL(string: "https://65c38b5339055e7482c12050.mockapi.io/api/suggestedProducts")!
        
        var responseData : [HorizontalProduct]?
        
        let urlRequest: Alamofire.URLRequestConvertible = URLRequest(url: realURL)
        AF.request(urlRequest).responseJSON { response in
            switch response.result {
            case .success :
                if let data = response.data {
                    do{
                        let responseDecoded = try JSONDecoder().decode([HorizontalWelcomeElement].self, from: data)
                        responseData = responseDecoded.first?.products
                    }catch let error as NSError {
                        print("Do error : ", error)
                    }
                    
                }
                
            case .failure(let error) :
                print("Error : ",error)
            }
        }
        
        return responseData
    }
    
    func getVerticalCardData() -> [VerticalProduct]? {
        return nil
    }
    
    
    
}
