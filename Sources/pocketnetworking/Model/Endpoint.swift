import Foundation

public protocol BaseEndpointProtocol {
    var baseURL: URL { get }
}

public protocol EndpointProtocol: BaseEndpointProtocol {
    var path: String { get }
    var method: HTTP.Method { get }
    var query: HTTP.Query { get }
    var headers: HTTP.Headers { get }
    var authorizationMethod: AuthorizationMethod { get }
    var decoder: ResponseDecoder { get }
    associatedtype Response: Decodable
}

public extension EndpointProtocol {
    var headers: [AnyHashable: String] {
        return [:]
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
        
        if let authorization = makeAuthorizationHeader() {
            request.setValue(authorization, forHTTPHeaderField: "Authorization")
        }
        
        return request as URLRequest
    }
    
    private func makeAuthorizationHeader() -> String? {
        switch authorizationMethod {
        case .bearer(let token):
            return "bearer " + token

        case .basic(let username, let password):
            let value = username + ":" + password
            guard let data = value.data(using: .utf8)?.base64EncodedString() else { return nil }
            return "Basic " + data

        case .none:
            return nil
        }
    }
    
    private func queryItems(from query: HTTP.Query) -> [URLQueryItem]? {
        
        guard query.isEmpty == false else { return nil }
        
        return query.map { (key, value) in URLQueryItem(name: key, value: value) }
    }
}

