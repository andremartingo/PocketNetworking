import Foundation
@testable import pocketnetworking

class BearerEndpoint: EndpointProtocol {    
    typealias Response = CurrentPriceResponse
    
    let baseURL: URL = .init(string: "https://api.coindesk.com")!
    let path = "/v1/bpi/currentprice.json"
    let method = HTTP.Method.get
    let query: HTTP.Query = [:]
    let headers: HTTP.Headers = [:]
    let authorizationMethod: AuthorizationMethod
    
    init(token: String) {
        self.authorizationMethod = .bearer(token: token)
    }
}

