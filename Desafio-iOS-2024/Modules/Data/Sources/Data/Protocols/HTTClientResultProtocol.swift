import Foundation

public enum HTTClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

//public protocol HTTPClient {
//    func get(from url: URL, completion: @escaping (HTTClientResult) -> Void)
//}


// Protocol for the service
protocol HTTClientResultProtocol {
    func performRequest(_ request: URLRequest, completion: @escaping (HTTClientResult) -> Void)
}

