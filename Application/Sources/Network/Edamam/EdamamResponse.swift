import Foundation

struct EdamamResponse: Decodable {
    
    enum NestedLinksCodingKey: String, CodingKey {
        case next
    }
    
    enum CodingKeys: String, CodingKey {
        case from
        case to
        case count
        case hits
        case nextLink = "_links"
    }
    
    let from, to, count: Int
    let hits: [Hit]
    let nextLink: EdamamLink?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.from = try container.decode(Int.self, forKey: .from)
        self.to = try container.decode(Int.self, forKey: .to)
        self.count = try container.decode(Int.self, forKey: .count)
        self.hits = try container.decode([Hit].self, forKey: .hits)
        
        let linksContainer = try container.nestedContainer(keyedBy: NestedLinksCodingKey.self, forKey: .nextLink)
        if let nextLink = try linksContainer.decodeIfPresent(EdamamLink.self, forKey: .next) {
            self.nextLink = nextLink
        } else {
            nextLink = nil
        }
    }
}

extension EdamamResponse {

    func toGenericModel() -> RecipeResponse {
        RecipeResponse(recipes: hits.compactMap { $0.recipe }.map { $0.toGenericModel() },
                       count: count,
                       nextLink: nextLink?.toGenericModel())
    }
}

// MARK: - Hit
struct Hit: Decodable {
    
    enum NestedLinksCodingKey: String, CodingKey {
        case recipeLink = "self"
    }
    
    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
    
    let recipe: EdamamRecipe?
    let link: EdamamLink
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.recipe = try container.decodeIfPresent(EdamamRecipe.self, forKey: .recipe)
        
        let linksContainer = try container.nestedContainer(keyedBy: NestedLinksCodingKey.self, forKey: .links)
        
        self.link = try linksContainer.decode(EdamamLink.self, forKey: .recipeLink)
    }
}

struct EdamamLink: Decodable {
    let href: String
}

extension EdamamLink {
    
    func toGenericModel() -> Link? {
        Link(href: href)
    }
}
