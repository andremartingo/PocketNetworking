//
//  File.swift
//  File
//
//  Created by Andre Martingo on 20.08.21.
//

import Foundation
@testable import pocketnetworking

struct CurrentPriceResponse: Decodable {
    let disclaimer: String
    let chartName: String
    let bpi: Currency
}

struct Currency: Decodable {
    let usd: CurrencyInfo
    let gbp: CurrencyInfo
    let eur: CurrencyInfo

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

struct CurrencyInfo: Decodable {
    let code: String
    let symbol: String
    let rate: String
    let description: String
    let rateFloat: Double

    enum CodingKeys: String, CodingKey {
        case code, symbol, rate
        case description = "description"
        case rateFloat = "rate_float"
    }
}

class CurrentPriceEndpoint: EndpointProtocol {
    typealias Response = CurrentPriceResponse
    
    let baseURL: URL = .init(string: "https://api.coindesk.com")!
    let path = "/v1/bpi/currentprice.json"
    let method = HTTP.Method.get
    let query: HTTP.Query = [:]
    let headers: HTTP.Headers = [:]
}

