import Foundation

public struct HTTP {
    
    public typealias Headers = [String: String]
    
    public typealias Query = [String: String]
    
    public enum Method: String {
        
        case get = "GET"
        case head = "HEAD"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
        case connect = "CONNECT"
        case options = "OPTIONS"
        case trace = "TRACE"
    }
    
    public struct Response {
        public let urlRequest: URLRequest
        public let data: Data?
        public let httpURLResponse: HTTPURLResponse?
        
        public var description: String {
            return """
            Requested URL: \(urlRequest.url?.absoluteString ?? "nil"),
            Status Code: \(httpURLResponse?.statusCode ?? -999),
            Data Count: \(data?.count ?? -999)
            """
        }

        public var debugDescription: String {
            return description
        }

        public var prettyJSONString: NSString? {
            return data?.prettyJSONString
        }
    }
}

private extension Data {
    var prettyJSONString: NSString? {
        guard
            let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let prettyPrintedData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            else { return nil }

        return NSString(data: prettyPrintedData, encoding: String.Encoding.utf8.rawValue)
    }
}

