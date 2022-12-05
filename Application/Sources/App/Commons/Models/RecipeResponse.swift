import Foundation

struct RecipeResponse {

    // MARK: - Properties
    let recipes: [Recipe]
    let count: Int
    let nextLink: Link?
}

struct Link {
    var href: String
}

struct RecipeHit {
    
    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
    
    let recipe: Recipe
    let link: Link
}
