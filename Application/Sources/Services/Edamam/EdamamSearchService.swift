import Foundation
import Alamofire

class EdamamSearchService: SearchService {
    let URL = "https://api.edamam.com/api/recipes/v2"
    let appID = "c18c9f08"
    let apiKey = "20cb82c63b8becd5a0050ee9ab6375f5"
    var queryText = "cheese"
    
    //https://api.edamam.com/api/recipes/v2?type=public&q=cheese&app_id=c18c9f08&app_key=20cb82c63b8becd5a0050ee9ab6375f5
    
//    func buildURLcall() {
//        return  (URL + "?type=public&q=" + queryText + "&app_id=" + appID + "&app_key=" + apiKey)
//    }
    
    func getData() {
        let request = AF.request("https://api.edamam.com/api/recipes/v2?type=public&q=cheese&app_id=c18c9f08&app_key=20cb82c63b8becd5a0050ee9ab6375f5")
        
        request.responseJSON { (data) in
            print(data)
        }
    }
    
    func getRecipies(page: Int, completionHandler: @escaping () -> Void) {
        <#code#>
    }
}
