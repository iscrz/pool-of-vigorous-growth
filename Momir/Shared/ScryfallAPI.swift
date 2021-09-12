//
//  ScryfallAPI.swift
//  Momir
//
//  Created by Brackelope on 9/10/21.
//

import Foundation
import Combine
import UIKit

enum ScryfallAPI {
    
    static func fetchData(manaValue: Int) -> AnyPublisher<CardResult, URLError> {
        
        return URLSession.shared
            .dataTaskPublisher(for: Self.url(manaValue: manaValue))
            .map { try! JSONDecoder().decode(DTO.Card.self, from: $0.data) }
            .map { card in
                
                URLSession
                    .shared
                    .dataTaskPublisher(for: URL(string: card.image_uris.normal)!)
                    .map { CardResult(data: card, image: UIImage(data: $0.data))  }
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
            

            
        
//        return URLSession.shared
//            .dataTaskPublisher(for: Self.url(manaValue: manaValue))
//            .map { try! JSONDecoder().decode(DTO.Card.self, from: $0.data) }
//            .sink { completion in
//                print(completion)
//            } receiveValue: { card in
//                print(card)
//            }
    }
    
    static func url(manaValue: Int) -> URL {
        
        let item = URLQueryItem(name: "q", value: "art:ravnica t:creature -is:token -o:search mv:\(manaValue)")
        
        var components = URLComponents()
        components.scheme = "https"
        components.path = "api.scryfall.com/cards/random"
        components.queryItems = [item]
        
        return components.url!
    }
    
    struct CardResult: Identifiable {
        let id = UUID().uuidString
        let data: DTO.Card
        let image: UIImage?
    }
    
    enum DTO {
        struct Card: Decodable {
            
            let id: String
            let name: String
            let image_uris: ImageURIs
            
            struct ImageURIs: Decodable {
                let small: String
                let normal: String
                let large: String
                let png: String
            }
        }
    }
    
}
