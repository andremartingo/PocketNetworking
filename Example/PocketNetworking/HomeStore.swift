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
        self.state = .init(image: "bitcoin", title: "BTC", subtitle: "Bitcoin", price1: "placeholder", price2: "placeholder", price3: "placeholder", isLoading: true)
    }
    
    func send(action: Action) {
        switch action {
        case .onAppear:
            Task {
                let result = await service.fetchPrice()
                switch result {
                case .success(let model):
                    self.state = updateState(with: model)

                case .failure:
                    var newState = self.state
                    newState.isLoading = false
                    newState.price1 = "Something Went Wrong"
                    self.state = newState
                }
            }
        }
    }
    
    private func updateState(with model: CurrentPriceResponse) -> HomeStore.State {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.groupingSize = 3
        var newState = self.state
        formatter.currencySymbol = getSymbolForCurrencyCode(code: model.bpi.eur.code)
        newState.price1 = formatter.string(from: model.bpi.eur.rateFloat as NSNumber) ?? ""
        formatter.currencySymbol = getSymbolForCurrencyCode(code: model.bpi.usd.code)
        newState.price2 = formatter.string(from: model.bpi.usd.rateFloat as NSNumber) ?? ""
        formatter.currencySymbol = getSymbolForCurrencyCode(code: model.bpi.gbp.code)
        newState.price3 = formatter.string(from: model.bpi.gbp.rateFloat as NSNumber) ?? ""
        newState.isLoading = false
        return newState
    }
    
    private func getSymbolForCurrencyCode(code: String) -> String? {
        let result = Locale.availableIdentifiers.map { Locale(identifier: $0) }.first { $0.currencyCode == code }
        return result?.currencySymbol
    }
    
}

extension HomeStore {
    struct State {
        var image: String
        var title: String
        var subtitle: String
        var price1: String
        var price2: String
        var price3: String
        var isLoading: Bool
    }
    
    enum Action {
        case onAppear
    }
    
}
