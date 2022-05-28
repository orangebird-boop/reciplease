import Foundation

struct EdamamResponse: Decodable {
    let hits: [Hit]
}

extension EdamamResponse {

    func toGenericModel() -> RecipeResponse {
        RecipeResponse(recipes: hits.compactMap { $0.recipe }.map { $0.toGenericModel() })
    }
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: EdamamRecipe?
}
