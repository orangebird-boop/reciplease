import Foundation

struct RecipeNext: Decodable {
    
    var href: String
    
}

enum RecipeTitle: String, Codable {
    case nextPage = "Next page"
    
}
