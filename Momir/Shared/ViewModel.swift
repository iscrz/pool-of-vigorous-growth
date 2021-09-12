//
//  ViewModel.swift
//  Momir
//
//  Created by Brackelope on 9/10/21.
//

import Foundation
import SwiftUI
import Combine

class ViewModel: ObservableObject {
    
    @Published private(set) var manaValue: Int = 0
    @Published var cards: [ScryfallAPI.CardResult] = []
    
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
        ScryfallAPI.fetchData(manaValue: manaValue)
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