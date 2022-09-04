import Foundation

struct RecipeResponse: Decodable {

    // MARK: - Properties

    let recipes: [Recipe]
    let count: Int
}
