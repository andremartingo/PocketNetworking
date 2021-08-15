import Foundation

protocol BaseEndpointProtocol {
    var baseURL: URL { get }
}

protocol EndpointProtocol: BaseEndpointProtocol {
    var path: String { get }
    var method: HTTP.Method { get }
    var query: HTTP.Query { get }
    var headers: HTTP.Headers { get }
    var authorizationMethod: AuthorizationMethod { get }
    var decoder: ResponseDecoder { get }
    associatedtype Response: Decodable
}

extension EndpointProtocol {
    var headers: [AnyHashable: String] {
        return [:]
    }

    var authorizationMethod: AuthorizationMethod {
        return .none
    }
    
    var decoder: ResponseDecoder {
        return JSONDecoder()
    }
}
