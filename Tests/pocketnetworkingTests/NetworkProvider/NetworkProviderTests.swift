import XCTest
@testable import pocketnetworking

final class NetworkProviderTests: XCTestCase {
    
    var sut: NetworkProvider!
    var networkLayerMock: NetworkLayerMock!
    
    override func setUp() {
        super.setUp()
        
        networkLayerMock = .init()
        sut = NetworkProvider(networkLayer: networkLayerMock)
    }
    
    override func tearDown() {
        super.tearDown()
        
        networkLayerMock = nil
        sut = nil
    }
    
    func test_request_Succeed() async {
        networkLayerMock.mockRequest = .success(.init(urlRequest: .mock(), data: nil, httpURLResponse: .mock()))
        guard case .success = await sut.request(endpoint: EmptyResponseEndpoint()) else { return XCTFail() }
    }
    
    func test_requestWithBadStatusCode_Failed() async {
        networkLayerMock.mockRequest = .success(.init(urlRequest: .mock(), data: nil, httpURLResponse: .mock(statusCode: 100)))
        guard case .failure = await sut.request(endpoint: EmptyResponseEndpoint()) else { return XCTFail() }
    }
    
    func test_requestWithBadResponse_Failed() async {
        networkLayerMock.mockRequest = .failure(.noData)
        guard case .failure = await sut.request(endpoint: EmptyResponseEndpoint()) else { return XCTFail() }
    }
    
    func test_requestWithEmptyResponse() async {
        let endpoint = EmptyResponseEndpoint()
        networkLayerMock.mockRequest = .success(.init(urlRequest: .mock(), data: nil, httpURLResponse: .mock()))
        guard case .success = await sut.request(endpoint: endpoint) else { return XCTFail() }
        guard let resource = networkLayerMock.resource else { return XCTFail() }
        XCTAssertEqual(resource.baseURL.absoluteString, endpoint.baseURL.absoluteString)
        XCTAssertEqual(resource.path, endpoint.path)
        XCTAssertEqual(resource.headers, [:])
        XCTAssertEqual(resource.query, [:])
        XCTAssertEqual(resource.method, .get)
        XCTAssertEqual(resource.body, nil)
    }
    
    func test_requestWithDecodable() async {
        let endpoint = CurrentPriceEndpoint()
        networkLayerMock.mockRequest = .success(.init(urlRequest: .mock(), data: validCurrentPriceResponse, httpURLResponse: .mock()))
        guard case .success(let model) = await sut.request(endpoint: endpoint) else { return XCTFail() }
        XCTAssertEqual(model.chartName, "Bitcoin")
        XCTAssertEqual(model.bpi.usd.code, "USD")
        XCTAssertEqual(model.bpi.usd.symbol, "&#36;")
        XCTAssertEqual(model.bpi.usd.rate, "48,471.6516")
        XCTAssertEqual(model.bpi.usd.description, "United States Dollar")
        XCTAssertEqual(model.bpi.usd.rateFloat, 48471.651)
    }
    
    func test_errorWhenNoDataWithNonEmptyResponse() async {
        let endpoint = CurrentPriceEndpoint()
        networkLayerMock.mockRequest = .success(.init(urlRequest: .mock(), data: nil, httpURLResponse: .mock()))
        guard case .failure(let error) = await sut.request(endpoint: endpoint) else { return XCTFail() }
        guard case .noData = error else { return XCTFail() }
    }
    
    func test_errorWhenFailDecoding() async {
        let endpoint = CurrentPriceEndpoint()
        networkLayerMock.mockRequest = .success(.init(urlRequest: .mock(), data: invalidCurrentPriceResponse, httpURLResponse: .mock()))
        guard case .failure(let error) = await sut.request(endpoint: endpoint) else { return XCTFail() }
        guard case .decoding = error else { return XCTFail() }
    }
}
