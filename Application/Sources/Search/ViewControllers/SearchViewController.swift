import Foundation
import UIKit

class SearchViewController: UIViewController {
    var searchViewModel = SearchViewModel()
    let searchView = SearchView()
    var ingredientsList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reciplease"
        
        setupViews()
        setupLayout()
    }
    
    func setupViews() {
        searchView.delegate = self
        searchView.backgroundColor = .yellow
        view.addSubview(searchView)
    }
    
    func setupLayout() {
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - SearchViewDelegate

extension SearchViewController: SearchViewDelegate {
    func didTapSearchButton() {
        searchViewModel.searchRecipies(with: ["chease", "ham"])
        let searchResultsVC = UIViewController()
        searchResultsVC.view.backgroundColor = .red
        navigationController?.pushViewController(searchResultsVC, animated: true)
    }
    
    func didTapAddButton() {
        
    }
}


extension SearchViewController: SearchViewModelDelegate {
    func didFindRecepies() {
        // todo refresh list of recipies
    }
    
    func didNotFindRecipe(error: Error) {
        // todo display error for user
    }
}
