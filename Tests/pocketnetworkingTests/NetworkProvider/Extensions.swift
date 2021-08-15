import Foundation

extension URLRequest {
    static func mock() -> URLRequest {
        return .init(url: .init(string: "https://api.coindesk.com")!)
    }
}

extension HTTPURLResponse {
    static func mock(statusCode: Int = 200) -> HTTPURLResponse? {
        return .init(url: .init(string: "https://api.coindesk.com")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
}

