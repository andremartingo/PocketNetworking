//
//  File.swift
//  File
//
//  Created by Andre Martingo on 20.08.21.
//

import Foundation
@testable import pocketnetworking

extension URLSession {
    static var mockedSuccess: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [SuccessMocking.self]
        configuration.timeoutIntervalForRequest = 1
        configuration.timeoutIntervalForResource = 1
        return URLSession(configuration: configuration)
    }
    
    static var mockedFailure: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [FailureMocking.self]
        configuration.timeoutIntervalForRequest = 1
        configuration.timeoutIntervalForResource = 1
        return URLSession(configuration: configuration)
    }
}

// MARK: - RequestMocking

private class SuccessMocking: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        let response = HTTPURLResponse(url: self.request.url!,
                                       statusCode: 200,
                                       httpVersion: "HTTP/1.1",
                                       headerFields: [:])!
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        self.client?.urlProtocol(self, didLoad: validCurrentPriceResponse)
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}

private class FailureMocking: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        self.client?.urlProtocol(self, didFailWithError: NetworkingError.none)
    }
    
    override func stopLoading() { }
}
