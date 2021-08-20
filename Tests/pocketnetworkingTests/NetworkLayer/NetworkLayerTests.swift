import XCTest
@testable import pocketnetworking

final class NetworkLayerTests: XCTestCase {
    func test_success() async {
        let sut = NetworkLayer(session: URLSession.mockedSuccess)
        let response = await sut.request(resource: .mock())
        guard case .success(let model) = response else { return XCTFail() }
        XCTAssertEqual(model.data, validCurrentPriceResponse)
    }
    
    func test_failure() async {
        let sut = NetworkLayer(session: URLSession.mockedFailure)
        let response = await sut.request(resource: .mock())
        guard case .failure(let error) = response else { return XCTFail() }
        guard case .underlying = error else { return XCTFail() }
    }
}
