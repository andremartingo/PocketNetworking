import Foundation

protocol NetworkLayerProtocol {
    func request(resource: Resource) async -> Result<HTTP.Response, NetworkingError>
}

class NetworkLayer: NetworkLayerProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request(resource: Resource) async -> Result<(HTTP.Response), NetworkingError> {
        if #available(iOSApplicationExtension 15.0, *) {
            do {
                let request = resource.request()
                let (data, response) = try await session.data(for: request)
                return .success(.init(urlRequest: request, data: data, httpURLResponse: response as? HTTPURLResponse))
            } catch {
                return .failure(.underlying(error, nil))
            }
        } else {
            fatalError()
        }
    }
}
