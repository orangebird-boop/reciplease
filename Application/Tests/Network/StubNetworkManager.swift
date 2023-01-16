import XCTest
@testable import Application

class StubNetworkManager: NetworkManager {
    var stubData: Decodable?
    var stubError: Error?
    override func get<T>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        if let stubError = stubError {
            completionHandler(.failure(stubError))
            return
        }
        if let stubData = stubData, let castedStubData = stubData as? T {
            completionHandler(.success(castedStubData))
        } else {
            completionHandler(.failure(NetworkManagerError.emptyData))
        }
    }
}
