import Foundation

struct EdamamIngredient: Codable {
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

extension EdamamIngredient {

    func toGenericModel() -> RecipeIngredients {
     
        RecipeIngredients(text: text, quantity: quantity, measure: measure, food: food, weight: weight, foodID: foodID)
        
    }
}
