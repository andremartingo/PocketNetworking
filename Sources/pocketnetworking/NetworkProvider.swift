import Foundation

public enum NetworkingError: Swift.Error {
    case none
    case noData
    case statusCode(HTTP.Response)
    case decoding(Swift.Error)
    case underlying(Swift.Error, HTTP.Response?)
}

public protocol NetworkProviderProtocol {
    func request<T: EndpointProtocol>(endpoint: T) async -> Result<T.Response, NetworkingError>
}

public class NetworkProvider: NetworkProviderProtocol {
    private let networkLayer: NetworkLayerProtocol
    
    public init() {
        self.networkLayer = NetworkLayer()
    }
    
    internal init(networkLayer: NetworkLayerProtocol = NetworkLayer()) {
        self.networkLayer = networkLayer
    }
    
    public func request<T: EndpointProtocol>(endpoint: T) async -> Result<T.Response, NetworkingError> {
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
        let result = await networkLayer.request(with: endpoint.makeRequest())
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


