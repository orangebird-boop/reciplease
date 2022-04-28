import Foundation

enum SearchServiceError: Error {
    case invalidURL
    case networkError
    case invalidData
    case invalidResponse(code: Int)
    case invalidJSONStructure
    
    var errorDescription: String? {
        switch self {
            
        case .invalidURL:
            return "Invalide URL"
        case .networkError:
            return "Network error"
        case .invalidData:
            return "Invalid Data"
        case .invalidResponse:
            return "Invalid response"
        case .invalidJSONStructure:
            return "Invalid JSON Response"
        }
    }
}

protocol SearchService {
    func getRecipies<T: Decodable>(page: Int, completionHandler: @escaping (Result<T, SearchServiceError>) -> Void)
}
