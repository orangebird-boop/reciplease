import Foundation
import Alamofire

class EdamamSearchService {

    typealias ServiceResponse = EdamamResponse

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
    
    func getRecipes(ingredients: [String], page: Int, completionHandler: @escaping (Result<EdamamResponse, SearchServiceError>) -> Void) {
        guard let url = buildUrl(for: ingredients) else {
            completionHandler(.failure(.invalidURL))
            
            return
        }
        print(url)
                let request = AF.request(url)
        
        request.responseJSON { networkResponse in
            guard let data = networkResponse.data else {
                completionHandler(.failure(.networkError))
                return
            }
            do {
                let response = try JSONDecoder().decode(EdamamResponse.self, from: data)
                completionHandler(.success(response))
            } catch {
                dump(error)
                completionHandler(.failure(.networkError))
            }
        }
    }
}
