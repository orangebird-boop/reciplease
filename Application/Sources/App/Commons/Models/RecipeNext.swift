import Foundation

struct RecipeNext: Decodable {
    
    var href: String
    var title: RecipeTitle
}

enum RecipeTitle: String, Codable {
    case nextPage = "Next page"
    
}
