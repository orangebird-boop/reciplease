import Foundation

enum SearchServiceError: Error, Equatable {
    case networkError
    case invalidData
    case invalidURL

    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Network error"
        case .invalidData:
            return "Invalid Data"
        case .invalidURL:
            return "Invalid URL"
        }
    }
}

protocol SearchService {
    associatedtype ServiceResponse
    
    func getRecipes(ingredients: [String], completionHandler: @escaping (Result<ServiceResponse, SearchServiceError>) -> Void)
}
