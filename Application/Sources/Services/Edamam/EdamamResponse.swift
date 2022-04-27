import Foundation

struct EdamamResponse: Codable {
    let from, to, count: Int
    let hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case hits
    }
}
// SERPARATE IN DIFFERENT FILES!
// MARK: - Hit
struct Hit: Codable {
    let recipe: EdamamRecipe

    enum CodingKeys: String, CodingKey {
        case recipe
      
    }
}

// MARK: - Recipe
struct EdamamRecipe: Codable {
    let uri, label, image: String
    let images: String?
    let source, url, shareAs: String
    let yield: Int
    let dietLabels, healthLabels, cautions, ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, glycemicIndex: Double
    let totalWeight: Int
    let cuisineType, mealType, dishType: [String]
    
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
