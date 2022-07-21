import Foundation

struct Recipe: Decodable {
    let name: String
    let foodImage: String?
    let url: String
    let ingredientLines: [String]
    let totalTime: Int?
}

extension Recipe: Hashable {
    
}
