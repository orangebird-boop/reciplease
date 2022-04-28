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
                recipies = response.hits.map { $0.recipe!}
                delegate?.didFindRecepies()
                
            case.failure(let error):
                dump(error)
                delegate?.didNotFindRecipe(error: error)
                
                
//                switch error {
//                    
//                case SearchServiceError.invalidURL:
//                 "An error occured, failed to retrieve recipies"
//                    
//                case SearchServiceError.networkError:
//                    return "Sorry, an internal error occured."
//                    
//                case SearchServiceError.invalidData:
//                    return "Sorry, there is a problem with the network, please try again later"
//                    
//                case SearchServiceError.invalidResponse(code: <#T##Int#>):
//                    return "An error occured, please contact our support team on the following adresse: support@reciplease.com"
//                    
//                case SearchServiceError.invalidJSONStructure:
//                    return
//
//                case default:
//                    
//                }
                
            }
        }
    }
}
