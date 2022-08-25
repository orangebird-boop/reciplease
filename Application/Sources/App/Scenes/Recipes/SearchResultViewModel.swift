import Foundation

class SearchResultViewModel {

    var recipes: [Recipe] = []

    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
}
