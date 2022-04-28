import Foundation
import Alamofire

class EdamamSearchService {

        enum EdamamSearchServiceError: LocalizedError {
            case failedToRetriveRecipies
            case invalidURL
            case networkError
            case defaultError
        
            var errorDescription: String? {
                switch self {
    
                case .failedToRetriveRecipies:
                    return "An error occured, failed to retrieve recipies"
    
                case .invalidURL:
                    return "Sorry, an internal error occured."
    
                case .networkError:
                    return "Sorry, there is a problem with the network, please try again later"
    
                case .defaultError:
                    return "An error occured, please contact our support team on the following adresse: support@reciplease.com"
                }
            }
        }


    let URL = "https://api.edamam.com/api/recipes/v2"
    let appID = "c18c9f08"
    let apiKey = "20cb82c63b8becd5a0050ee9ab6375f5"
    var queryText = "cheese"
    
    //https://api.edamam.com/api/recipes/v2?type=public&q=cheese&app_id=c18c9f08&app_key=20cb82c63b8becd5a0050ee9ab6375f5
    
//    func buildURLcall() {
//        return  (URL + "?type=public&q=" + queryText + "&app_id=" + appID + "&app_key=" + apiKey)
//    }
    
    func getRecipies(page: Int, completionHandler: @escaping (Result<EdamamResponse, SearchServiceError>) -> Void) {
        let request = AF.request("https://api.edamam.com/api/recipes/v2?type=public&q=cheese&app_id=c18c9f08&app_key=20cb82c63b8becd5a0050ee9ab6375f5")
        
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
