import Foundation

class EdamamSearchService: SearchService {

    
    

    typealias ServiceResponse = RecipeResponse

    private var networkService: NetworkManager
    
    init(networkService: NetworkManager = .init()) {
        self.networkService = networkService
    }
    
    let path = "https://api.edamam.com/api/recipes/v2"
    let appID = "c18c9f08"
    let apiKey = "20cb82c63b8becd5a0050ee9ab6375f5"
    
    func buildUrl(for ingredients: [String]) -> String? {
            var urlComponents = URLComponents(string: path)
            urlComponents?.queryItems = []
            urlComponents?.queryItems?.append(URLQueryItem(name: "type", value: "public"))
            urlComponents?.queryItems?.append(URLQueryItem(name: "q", value: ingredients.joined(separator: " ")))
            urlComponents?.queryItems?.append(URLQueryItem(name: "app_id", value: appID))
            urlComponents?.queryItems?.append(URLQueryItem(name: "app_key", value: apiKey))
            
            return urlComponents?.url?.absoluteString
        }
    
    func getRecipes(nextSet: String, completionHandler: @escaping (Result<RecipeResponse, SearchServiceError>) -> Void) {
        guard let url = URL(string: nextSet) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        networkService.get(request: URLRequest(url: url)) { (result: Result<EdamamResponse, Error>) in
            switch result {
            case .success(let response):
                // Model transformation
                let recipeResponse = response.toGenericModel()
                
                completionHandler(.success(recipeResponse))
                
            case .failure(let error):
                completionHandler(.failure(self.handle(error: error)))
            }
        }
    }
    
    func getRecipes(ingredients: [String], completionHandler: @escaping (Result<RecipeResponse, SearchServiceError>) -> Void) {
        guard let rawURL = buildUrl(for: ingredients), let url = URL(string: rawURL) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        networkService.get(request: URLRequest(url: url)) { (result: Result<EdamamResponse, Error>) in
            switch result {
            case .success(let response):
                // Model transformation
                let recipeResponse = response.toGenericModel()
                
                
                completionHandler(.success(recipeResponse))
                
            case .failure(let error):
                completionHandler(.failure(self.handle(error: error)))
            }
        }
    }
    
    func handle(error: Error) -> SearchServiceError {
        guard let networkError = error as? NetworkManagerError else {
            return .networkError
        }
    
        switch networkError {
        case .invalidURL:
            return.invalidURL
        case .emptyData, .failedToDeserialize:
            return .invalidData
        case .redirection, .httpClientError, .serverError, .unknown:
            return .networkError
        }
    }
}
