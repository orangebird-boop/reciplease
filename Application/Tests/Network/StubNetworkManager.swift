import XCTest
@testable import Application

class StubNetworkManager: NetworkManager {
    var stubData: Decodable?
    var stubError: NetworkManager.NetworkManagerError?
    override func get<T>(request: URLRequest, completionHandler: @escaping (Result<T, NetworkManager.NetworkManagerError>) -> Void) where T: Decodable {
        if let stubError = stubError {
            completionHandler(.failure(stubError))
            return
        }
        if let stubData = stubData, let castedStubData = stubData as? T {
            completionHandler(.success(castedStubData))
        } else {
            completionHandler(.failure(.emptyData))
        }
    }
}
