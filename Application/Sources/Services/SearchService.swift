import Foundation

enum SearchServiceError: Error {
    case networkError
}

protocol SearchService {
    func getRecipies<T: Decodable>(page: Int, completionHandler: @escaping (Result<T, SearchServiceError>) -> Void)
}
