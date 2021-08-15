import Foundation
@testable import pocketnetworking

class EmptyResponseEndpoint: EndpointProtocol {
    typealias Response = EmptyResponse
    
    let baseURL: URL = .init(string: "https://api.coindesk.com")!
    let path = "/v1/bpi/currentprice.json"
    let method = HTTP.Method.get
    let query: HTTP.Query = [:]
    let headers: HTTP.Headers = [:]
}
