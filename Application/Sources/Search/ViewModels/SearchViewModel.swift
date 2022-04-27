import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func didFindRecepies()
    func didNotFindRecipe(error: Error)
}
class SearchViewModel {
    
    private let searchService: EdamamSearchService
    private (set) var recipies: [EdamamRecipe] = []
    weak var delegate: SearchViewModelDelegate?
    
    init(searchService: EdamamSearchService = EdamamSearchService()) {
        self.searchService = searchService
    }
    
    func searchRecipies(with ingredients: [String]) {
        searchService.getRecipies(page: 0) { [unowned self] result in
            switch result {
            case.success(let response):
                dump(response)
                recipies = response.hits.map { $0.recipe}
                delegate?.didFindRecepies()
                
            case.failure(let error):
                dump(error)
                delegate?.didNotFindRecipe(error: error)
                // HUMAN READABLE ERROR
            }
        }
    }
}
