import Foundation

protocol SearchViewModelDelegate: AnyObject {
    
}
class SearchViewModel {
    weak var delegate: SearchViewModelDelegate?
}
