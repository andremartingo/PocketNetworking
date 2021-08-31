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

extension EndpointProtocol {
    func makeRequest() -> URLRequest {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        
        components?.queryItems = queryItems(from: query)
        components?.path = path
        
        
        let request = NSMutableURLRequest(url: components?.url ?? baseURL)
        
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        
        
        return request as URLRequest
    }
    
    private func queryItems(from query: HTTP.Query) -> [URLQueryItem]? {
        
        guard query.isEmpty == false else { return nil }
        
        return query.map { (key, value) in URLQueryItem(name: key, value: value) }
    }
}

