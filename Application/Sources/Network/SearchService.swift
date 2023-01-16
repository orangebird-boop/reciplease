import Foundation

enum SearchServiceError: Error, Equatable {
    case networkError
    case invalidData

    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Network error"
        case .invalidData:
            return "Invalid Data"
        }
    }
}

protocol SearchService {
    associatedtype ServiceResponse: Decodable
    
    func getRecipes(page: Int, completionHandler: @escaping (Result<ServiceResponse, SearchServiceError>) -> Void)
}
