import Foundation

struct RecipeIngredients: Decodable {
    var text: String
//    let quantity: Double
//    let measure: String
//    let food: String
//    let weight: Double
//    let foodID: String
}

extension RecipeIngredients: Hashable {
    
}
