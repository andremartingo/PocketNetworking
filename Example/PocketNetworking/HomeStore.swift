//
//  HomeStore.swift
//  HomeStore
//
//  Created by Andre Martingo on 01.09.21.
//

import SwiftUI

@MainActor
final class HomeStore: ObservableObject {
    @Published
    private (set) var state: State
    
    private let service: CoinbaseServiceProtocol
    
    init(service: CoinbaseServiceProtocol = CoinbaseService()) {
        self.service = service
        self.state = .init(price: "Loading")
    }
    
    func send(action: Action) {
        switch action {
        case .onAppear:
            Task {
                let result = await service.fetchPrice()
                switch result {
                case .success(let model):
                    self.state = .init(price: model.bpi.eur.rate)
                case .failure(let error):
                    print(error)
                    self.state = .init(price: "Error")
                }
            }
        }
    }
    
}

extension HomeStore {
    struct State {
        let price: String
        
        init(price: String) {
            self.price = price
        }
    }
    
    enum Action {
        case onAppear
    }
    
}
