import Foundation
import Alamofire

class EdamamSearchService {

    typealias ServiceResponse = EdamamResponse

    let path = "https://api.edamam.com/api/recipes/v2"
    let appID = "c18c9f08"
    let apiKey = "20cb82c63b8becd5a0050ee9ab6375f5"
//    var queryText = "cheese"
//    let encoding = URLEncoding(arrayEncoding: .noBrackets)
 
    //https://api.edamam.com/api/recipes/v2?type=public&q=cheese&app_id=c18c9f08&app_key=20cb82c63b8becd5a0050ee9ab6375f5

    func buildUrl(for originalText: String) -> String {
       
        print(path + "?type=public&q=" + originalText + "&app_id=c18c9f08&app_key=20cb82c63b8becd5a0050ee9ab6375f5")

        return path + "?type=public&q=" + originalText + "&app_id=c18c9f08&app_key=20cb82c63b8becd5a0050ee9ab6375f5"
            }
    
    func getRecipes(ingredients: String, page: Int, completionHandler: @escaping (Result<EdamamResponse, SearchServiceError>) -> Void) {
        
                let request = AF.request(buildUrl(for: ingredients))
        
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
