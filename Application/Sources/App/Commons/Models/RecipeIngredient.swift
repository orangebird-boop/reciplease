import Foundation

struct RecipeIngredient: Decodable {
    var text: String

}

extension RecipeIngredient: Hashable {
    
}
