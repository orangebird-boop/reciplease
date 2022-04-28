import Foundation

struct EdamamResponse: Decodable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: EdamamRecipe?
}

// MARK: - Recipe
struct EdamamRecipe: Decodable {
    let label: String
    let image: String?
    let url: String
    let yield: Double?
    let ingredientLines: [String]
    let totalTime: Int?
}
// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
    let quantity: Double
    let measure, food: String
    let weight: Double
    let foodID: String

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight
        case foodID = "foodId"
    }
}
