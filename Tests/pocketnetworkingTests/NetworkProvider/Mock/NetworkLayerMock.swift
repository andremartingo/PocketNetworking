//
//  File.swift
//  File
//
//  Created by Andre Martingo on 19.08.21.
//

import Foundation
@testable import pocketnetworking

class NetworkLayerMock: NetworkLayerProtocol {
    var mockRequest: Result<HTTP.Response, NetworkingError> = .success(.init(urlRequest: URLRequest(url: URL(string: "www.apple.com")!), data: nil, httpURLResponse: nil))
    
    var resource: Resource?
    
    func request(resource: Resource) async -> Result<HTTP.Response, NetworkingError> {
        self.resource = resource
        return mockRequest
    }
}
