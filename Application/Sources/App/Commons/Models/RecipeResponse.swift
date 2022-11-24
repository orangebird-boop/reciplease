import Foundation

struct RecipeResponse: Decodable {

    // MARK: - Properties

    let recipes: [Recipe]
    let count: Int
}

struct RecipeHit: Decodable {
    let recipe: Recipe
    let links: RecipeHitLinks
}
