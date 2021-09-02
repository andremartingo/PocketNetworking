//
//  CoinbaseService.swift
//  CoinbaseService
//
//  Created by Andre Martingo on 01.09.21.
//

import Foundation
import pocketnetworking

protocol CoinbaseServiceProtocol {
    func fetchPrice() async -> Result<CurrentPriceResponse, NetworkingError>
}

class CoinbaseService: CoinbaseServiceProtocol {
    
    private let network: NetworkProviderProtocol
    
    init(network: NetworkProviderProtocol = NetworkProvider()) {
        self.network = network
    }

    func fetchPrice() async -> Result<CurrentPriceResponse, NetworkingError> {
        let endpoint = CurrentPriceEndpoint()
        return await network.request(endpoint: endpoint)
    }
}
