import Foundation

enum NetworkingError: Swift.Error {
    case none
    case noData
    case statusCode(HTTP.Response)
    case decoding(Swift.Error)
    case underlying(Swift.Error, HTTP.Response?)
}

protocol NetworkProviderProtocol {
    func request<T: EndpointProtocol>(endpoint: T) async -> Result<T.Response, NetworkingError>
}

class NetworkProvider: NetworkProviderProtocol {
    private let networkLayer: NetworkLayerProtocol
    
    init(networkLayer: NetworkLayerProtocol) {
        self.networkLayer = networkLayer
    }
    
    func request<T: EndpointProtocol>(endpoint: T) async -> Result<T.Response, NetworkingError> {
        let response = await requestRaw(endpoint: endpoint)
        switch response {
        case .success(let data):
            if T.Response.self is EmptyResponse.Type {
                guard let emptyResponse = EmptyResponse() as? T.Response else { return .failure(.none) }
                return .success(emptyResponse)
            } else {
                guard let data = data else { return .failure(.noData) }
                do {
                    let model = try endpoint.decoder.decode(T.Response.self, from: data)
                    return .success(model)
                } catch {
                    return .failure(.decoding(error))
                }
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func requestRaw<T: EndpointProtocol>(endpoint: T) async -> Result<Data?, NetworkingError> {
        let resource = Resource(baseURL: endpoint.baseURL,
                                path: endpoint.path,
                                method: endpoint.method,
                                body: nil,
                                headers: endpoint.headers,
                                query: endpoint.query)
        let result = await networkLayer.request(resource: resource)
        switch result {
        case .success(let response):
            guard let httpURLResponse = response.httpURLResponse, 200..<300 ~= httpURLResponse.statusCode else {
                return .failure(.statusCode(response))
            }
            
            return .success(response.data)
            
        case .failure(let error):
            return .failure(error)
        }
    }
}


