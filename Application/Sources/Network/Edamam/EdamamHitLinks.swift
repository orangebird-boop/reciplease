import Foundation

// MARK: - HitLinks
struct EdamamHitLinks: Decodable {
    let linksSelf: EdamamNext
}

extension EdamamHitLinks {

    func toGenericModel() -> RecipeHitLinks {
     
        RecipeHitLinks(linksSelf: RecipeNext.init(href: linksSelf.href, title: RecipeTitle.nextPage))
        
    }
}
