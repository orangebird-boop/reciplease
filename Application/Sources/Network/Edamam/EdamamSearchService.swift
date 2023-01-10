import Foundation
import Alamofire

class EdamamSearchService {

    typealias ServiceResponse = RecipeResponse

    let path = "https://api.edamam.com/api/recipes/v2"
    let appID = "c18c9f08"
    let apiKey = "20cb82c63b8becd5a0050ee9ab6375f5"
	
	private var networkService: NetworkService
	
	init(networkService: NetworkService = .init()) {
		self.networkService = networkService
	}
	
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
		
		networkService.get(request: URLRequest(url: url)) { (result: Result<EdamamResponse, ServiceError>) in
			switch result {
			case .success(let response):
				// Model transformation
				let recipeResponse = response.toGenericModel()

				completionHandler(.success(recipeResponse))
				
			case .failure(let failure):
				completionHandler(.failure(.networkError))
			}
		}
    }
    
    func getRecipes(ingredients: [String], completionHandler: @escaping (Result<RecipeResponse, SearchServiceError>) -> Void) {
        guard let url = buildUrl(for: ingredients) else {
            completionHandler(.failure(.invalidURL))
            return
        }

        let request = AF.request(url)
        
        request.responseJSON { networkResponse in
            guard let data = networkResponse.data else {
                completionHandler(.failure(.networkError))
                return
            }
            do {
                let response = try JSONDecoder().decode(EdamamResponse.self, from: data)

                // Model transformation
                let recipeResponse = response.toGenericModel()
                print(recipeResponse)
                completionHandler(.success(recipeResponse))
            } catch {
                dump(error)
                completionHandler(.failure(.networkError))
            }
        }
    }
}
