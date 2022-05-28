import Foundation

struct RecipeIngredients: Decodable {
    let text: String
    let quantity: Double
    let measure: String
    let food: String
    let weight: Double
    let foodID: String
}
