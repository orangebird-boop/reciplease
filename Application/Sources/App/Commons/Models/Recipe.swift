import Foundation

struct Recipe: Decodable {
    
    let name: String
    let foodImage: String?
    let url: String
    let ingredientLines: [String]
    let totalTime: Int?
}

extension Recipe: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(url)
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        (lhs.name, lhs.url) == (rhs.name, rhs.url)
    }
}


