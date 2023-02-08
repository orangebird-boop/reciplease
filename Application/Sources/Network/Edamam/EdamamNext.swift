import Foundation

// MARK: - Next

struct EdamamNext: Decodable {
    let href: String
}

extension EdamamNext {

    func toGenericModel() -> RecipeNext {
     
        RecipeNext(href: href)
    }
}
