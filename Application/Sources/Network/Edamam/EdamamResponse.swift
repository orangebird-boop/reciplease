import Foundation

struct EdamamResponse: Decodable {
    
    let from, to, count: Int
    let hits: [Hit]
}

extension EdamamResponse {

    func toGenericModel() -> RecipeResponse {
        RecipeResponse(recipes: hits.compactMap { $0.recipe }.map { $0.toGenericModel() }, count: count)
    }
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: EdamamRecipe?
    let links: HitLinks
    
    enum CodingKeys: String, CodingKey {
           case recipe
           case links = "_links"
       }
}
