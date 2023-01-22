import Foundation

struct EdamamRecipe: Decodable, Hashable {
    let label: String
    let image: String?
    let url: String
    let ingredientLines: [String]
    let totalTime: Int?

    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
        hasher.combine(url)
    }
}

extension EdamamRecipe {

    func toGenericModel() -> Recipe {
     
        Recipe(name: label, foodImage: image, url: url, ingredientLines: ingredientLines, totalTime: totalTime)
        
    }
}
