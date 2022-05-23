import Foundation

struct EdamamRecipe: Decodable, Hashable {
    let label: String
    let image: String?
    let url: String
    let yield: Double?
    let ingredientLines: [String]
    let totalTime: Int?

    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
        hasher.combine(url)
    }
}

extension EdamamRecipe {

    func toGenericModel() -> Recipe {
     
        Recipe(name: label, foodImage: image)
        
    }
}
