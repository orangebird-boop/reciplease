import Foundation

struct Recipe: Decodable {
    let name: String
    let foodImage: String?
}

extension Recipe: Hashable {
    
}
