import Foundation

class EdamamSearchService {
    
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
    
    func getRecipes(nextSet: String, completionHandler: @escaping (Result<RecipeResponse, Error>) -> Void) {
        guard let url = URL(string: nextSet) else {
            completionHandler(.failure(SearchServiceError.networkError))
            return
        }
        
        networkService.get(request: URLRequest(url: url)) { (result: Result<EdamamResponse, Error>) in
            switch result {
            case .success(let response):
                // Model transformation
                let recipeResponse = response.toGenericModel()
                
                completionHandler(.success(recipeResponse))
                
            case .failure:
                completionHandler(.failure(SearchServiceError.networkError))
            }
        }
    }
    
    func getRecipes(ingredients: [String], completionHandler: @escaping (Result<RecipeResponse, Error>) -> Void) {
        guard let rawURL = buildUrl(for: ingredients), let url = URL(string: rawURL) else {
            completionHandler(.failure(self.handle(error: .invalidURL)))
            return
        }
        
        networkService.get(request: URLRequest(url: url)) { (result: Result<EdamamResponse, Error>) in
            switch result {
            case .success(let response):
                // Model transformation
                let recipeResponse = response.toGenericModel()
                
                completionHandler(.success(recipeResponse))
                
            case .failure:
                completionHandler(.failure(self.handle(error: .serverError)))
            }
        }
    }
    
    func handle(error: NetworkManagerError) -> SearchServiceError {
        switch error {
        case .emptyData, .failedToDeserialize:
            return .invalidData
        case .redirection, .httpClientError, .serverError, .unknown, .invalidURL:
            return .networkError
        }
    }
}
