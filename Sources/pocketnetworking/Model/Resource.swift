import Foundation

struct Resource: Equatable {
    
    // MARK: - Properties
    
    var path: String
    var method: HTTP.Method
    var headers: HTTP.Headers
    var body: Data?
    var query: HTTP.Query
    let baseURL: URL
    
    // MARK: - Lifecycle
    
    init(baseURL: URL, path: String, method: HTTP.Method, body: Data? = nil, headers: HTTP.Headers = [:], query: HTTP.Query = [:]) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.body = body
        self.query = query
    }
}

extension Resource {
    func request() -> URLRequest {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        
        components?.queryItems = queryItems(from: query)
        components?.path = path
        
        
        let request = NSMutableURLRequest(url: components?.url ?? baseURL)
        
        request.httpBody = body
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        
        
        return request as URLRequest
    }
    
    private func queryItems(from query: HTTP.Query) -> [URLQueryItem]? {
        
        guard query.isEmpty == false else { return nil }
        
        return query.map { (key, value) in URLQueryItem(name: key, value: value) }
    }
}

