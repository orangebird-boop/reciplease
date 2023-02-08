import Foundation

// MARK: - HitLinks
struct EdamamNextLinks: Decodable {
    let next: EdamamLink
}

extension EdamamNextLinks {

    func toGenericModel() -> RecipeHitLinks {
     
        RecipeHitLinks(next: RecipeNext.init(href: next.href))
    }
}
