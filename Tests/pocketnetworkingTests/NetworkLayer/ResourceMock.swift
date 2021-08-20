import XCTest
@testable import pocketnetworking

extension Resource {
    static func mock() -> Resource {
        return .init(baseURL: .init(string: "www.apple.com")!, path: "api/v1", method: .get)
    }
}
