//
//  File.swift
//  File
//
//  Created by Andre Martingo on 15.09.21.
//

import Foundation
@testable import pocketnetworking

class BasicEndpoint: EndpointProtocol {
    typealias Response = CurrentPriceResponse
    
    let baseURL: URL = .init(string: "https://api.coindesk.com")!
    let path = "/v1/bpi/currentprice.json"
    let method = HTTP.Method.get
    let query: HTTP.Query = [:]
    let headers: HTTP.Headers = [:]
    let authorizationMethod: AuthorizationMethod
    
    init(username: String, password: String) {
        self.authorizationMethod = .basic(username: username, password: password)
    }
}
