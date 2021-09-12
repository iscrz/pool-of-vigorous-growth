//
//  ViewModel.swift
//  Momir
//
//  Created by Brackelope on 9/10/21.
//

import Foundation
import SwiftUI
import Combine

struct CardRequest: Identifiable {
    let id = UUID().uuidString
    let manaValue: Int
}

class CardState: ObservableObject {
    
    @Published var image: UIImage?
    
    let request: CardRequest
    
    var fetchToken: AnyCancellable?
    
    init(_ request: CardRequest) {
        self.request = request
        
        fetchToken = ScryfallAPI.fetchData(manaValue: request.manaValue)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { cardResult in
                self.image = cardResult.image
            }
        
    }
}

class ViewModel: ObservableObject {
    
    @Published private(set) var manaValue: Int = 0
    @Published var cards: [ScryfallAPI.CardResult] = []
    @Published var cardRequests: [CardRequest] = []
    
    var subs = [AnyCancellable]()

    var buttonTitle: String {
        "\(manaValue)"
    }
    
    func incCount() {
        manaValue = min(20, manaValue + 1)
    }
    
    func decCount() {
        manaValue = max(0, manaValue - 1)
    }
    
    func submit() {
        
        cardRequests.append(CardRequest(manaValue: manaValue))
        
        return ScryfallAPI.fetchData(manaValue: manaValue)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { cardResult in
                print(cardResult)
                self.cards.append(cardResult)
            }
            .store(in: &subs)
    }

}
