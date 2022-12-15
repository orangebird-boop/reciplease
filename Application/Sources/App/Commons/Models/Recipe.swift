import Foundation

struct Recipe: Decodable {
    
    let name: String
    let foodImage: String?
    let url: String
    let ingredientLines: [String]
    let totalTime: Int?
    let nextURL: RecipeNext
    
}

extension Recipe: Hashable {
 
    

}
